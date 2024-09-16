#!/bin/bash

# Colors for output
RED='\033[0;31m'
YELLOW='\033[0;33m'
GREEN='\033[0;32m'
NC='\033[0m'  # No color

# Specify the branch name for Git operations
BRANCH="vishalk17-server"  # Replace with your preferred branch name

# Define the list of paths to be copied 
PATHS=(
    "/etc/mysql/mysql.cnf"
    "/etc/logrotate.d/jenkins"
    "/home/vishal/fluentd/enable"
    # "/home/xyz_dir/."        # this is how you can add whole directory
)

# Ensure the script is run with sudo
if [ "$(id -u)" -ne 0 ]; then
    echo -e "${RED}This script must be run as root (sudo).${NC}" >&2
    exit 1
fi

# Function to pull latest changes
git_pull_latest() {
    script_dir=$(dirname "$0")
    cd "$script_dir" || exit 1

    echo "-------------------------------------------------------------------"
    echo -e "${YELLOW}Would you like to pull the latest changes from Current branch $BRANCH before proceeding? [y/n]: ${NC}"
    echo "-------------------------------------------------------------------"  
    read -r pull_choice
    if [[ "$pull_choice" == "y" || "$pull_choice" == "Y" ]]; then
        echo "-------------------------------------------"
        echo -e "${YELLOW}Pulling latest changes from branch $BRANCH...${NC}"
        echo "-------------------------------------------"
        if ! git pull origin "$BRANCH"; then
            echo "-------------------------------------------"
            echo -e "${RED}Error pulling latest changes from current branch $BRANCH.${NC}" >&2
            echo "-------------------------------------------"
            exit 1
        fi
    else
        echo "-------------------------------------------"
        echo -e "${RED}Proceeding without pulling latest changes.${NC}"
        echo "-------------------------------------------"
    fi
}

# Function to update the repository with local configuration files
update_repo() {
    git_pull_latest  # Ask to pull latest changes before backup

    echo "------------------------------------------------------"
    echo -e "${YELLOW}Updating the repository with local configuration files${NC}"
    echo "------------------------------------------------------"
    # Record ownership information
    ownership_file="ownership.txt"
    > "$ownership_file"
    for src_path in "${PATHS[@]}"; do
        if [ -e "$src_path" ]; then
            # Record permissions, owner, and group information
            stat -c "%a %U %G %n" "$src_path" >> "$ownership_file"
            # Copy the file to the repository preserving the path structure
            dest_path=".${src_path}"
            mkdir -p "$(dirname "$dest_path")"
            cp -rp "$src_path" "$dest_path"
        else
            echo "-------------------------------------------"
            echo -e "${RED}Warning: $src_path does not exist and will not be included.${NC}" >&2
            echo "-------------------------------------------"
        fi
    done

    # Add and commit changes
    script_dir=$(dirname "$0")
    cd "$script_dir" || exit 1

    git add -u
    git add .  # For newly created files

    # Get current date and time in IST
    IST_DATE_TIME=$(TZ=Asia/Kolkata date +"%Y-%m-%d %T %Z")

    # Default commit message with IST date and time
    COMMIT_MESSAGE="Automated backup on $IST_DATE_TIME"

    echo "---------------------------"
    echo -e "${YELLOW}Committing Changes.........${NC}"
    echo "---------------------------"
    git commit -m "$COMMIT_MESSAGE"
    echo "---------------------------"
    echo -e "${YELLOW}Pushing Changes to the git .......${NC}"
    echo "---------------------------"

    # Push changes to the specified branch
    if git push origin "$BRANCH"; then
        echo "-------------------------------------------"
        echo -e "${GREEN}Changes pushed to branch $BRANCH successfully.${NC}"
        echo "-------------------------------------------"
    else
        echo "-------------------------------------------"
        echo -e "${RED}Error pushing changes to branch $BRANCH.${NC}" >&2
        echo "-------------------------------------------"
        exit 1
    fi
}

# Function to pull updates from the repository and prompt user to apply them
apply_updates() {
    git_pull_latest  # Ask to pull latest changes before restore

    # Prompt user to apply updates
    read -p "$(echo -e ${GREEN}Apply updated files now? [y/n]: ${NC})" apply_choice
    case $apply_choice in
        y|Y)
            echo "-------------------------------------------"
            echo -e "${GREEN}Applying updates...${NC}"
            echo "-------------------------------------------"
            # Copy the files to their respective paths
            for src_path in "${PATHS[@]}"; do
                dest_path=".${src_path}"
                if [ -e "$dest_path" ]; then
                    cp -rp "$dest_path" "$src_path"
                else
                    echo "--------------------------------------------------------------"
                    echo -e "${RED}Warning: $dest_path does not exist and cannot be applied.${NC}" >&2
                    echo "--------------------------------------------------------------"
                fi
            done

            # Restore ownership and permissions information
            restore_permissions
            ;;
        n|N)
            echo -e "${RED}Updates were pulled but not applied.${NC}"
            ;;
        *)
            echo -e "${RED}Invalid choice. Updates were pulled but not applied.${NC}"
            ;;
    esac
}

# Function to restore ownership and permissions from ownership.txt
restore_permissions() {
    ownership_file="ownership.txt"
    if [ -e "$ownership_file" ]; then
        echo "-----------------------------------------------------------"
        echo -e "${GREEN}Restoring ownership and permissions from $ownership_file...${NC}"
        echo "-----------------------------------------------------------"
        while IFS= read -r line; do
            perms=$(echo "$line" | cut -d' ' -f1)
            user=$(echo "$line" | cut -d' ' -f2)
            group=$(echo "$line" | cut -d' ' -f3)
            file=$(echo "$line" | cut -d' ' -f4-)
            if [ -e "$file" ]; then
                chmod "$perms" "$file"
                chown "$user:$group" "$file"
            else
                echo "--------------------------------------------------------------------"
                echo -e "${RED}Warning: $file does not exist and ownership cannot be restored.${NC}" >&2
                echo "--------------------------------------------------------------------"
            fi
        done < "$ownership_file"
    else
        echo "--------------------------------------------------------------"
        echo -e "${RED}Warning: Ownership file $ownership_file does not exist and ownership cannot be restored.${NC}" >&2
        echo "--------------------------------------------------------------"
    fi
}

# Function to check permissions and ownerships against the recorded ownership.txt
check_permissions() {
    git_pull_latest  # Ask to pull latest changes before checking permissions

    ownership_file="ownership.txt"
    if [ -e "$ownership_file" ]; then
        echo "-----------------------------------------------------------"
        echo -e "${YELLOW}Checking permissions and ownerships against $ownership_file...${NC}"
        echo "-----------------------------------------------------------"
        issues_found=false  # Flag to track if any issues are found

        while IFS= read -r line; do
            perms_expected=$(echo "$line" | cut -d' ' -f1)
            user_expected=$(echo "$line" | cut -d' ' -f2)
            group_expected=$(echo "$line" | cut -d' ' -f3)
            file=$(echo "$line" | cut -d' ' -f4-)

            if [ -e "$file" ]; then
                perms_actual=$(stat -c "%a" "$file")
                user_actual=$(stat -c "%U" "$file")
                group_actual=$(stat -c "%G" "$file")

                if [[ "$perms_actual" != "$perms_expected" || "$user_actual" != "$user_expected" || "$group_actual" != "$group_expected" ]]; then
                    echo "------------------"
                    echo -e "--${RED}Issues Found${NC}--"
                    echo "------------------"
                    echo "File name: $file"
                    echo -e "${YELLOW}Permission must be: $perms_expected, User must be: $user_expected, Group must be: $group_expected${NC}"
                    echo -e "${RED}Permission we have: $perms_actual, User we have: $user_actual, Group we have: $group_actual${NC}"
                    echo "------------------"
                    issues_found=true  # Set flag to true if any issue is found
                fi
            else
                echo "-----------------------------------------------------------"
                echo -e "${RED}Warning: $file does not exist and cannot be checked.${NC}" >&2
                echo "-----------------------------------------------------------"
            fi
        done < "$ownership_file"

        if ! $issues_found; then
            echo "-------------------"
            echo -e "--${GREEN}No issues found${NC}--"
            echo "-------------------"
        fi
    else
        echo "-----------------------------------------------------------"
        echo -e "${RED}Warning: Ownership file $ownlsership_file does not exist, so permissions cannot be checked.${NC}" >&2
        echo "-----------------------------------------------------------"
    fi
    echo "---------------------"
    echo -e "${GREEN}Finished script.${NC}"
}

# Function to display menu and handle user choice
display_menu() {
    echo "Menu:"
    echo "1. Update repository with local configuration files"
    echo "2. Pull updates from repository and apply to system paths"
    echo "3. Restore only permissions and ownerships from ownership.txt"
    echo "4. Check current permissions and ownerships against ownership.txt"
    echo "5. Exit"

    read -p "$(echo -e ${GREEN}Enter your choice [1-5]: ${NC})" choice
    case $choice in
        1) update_repo;;
        2) apply_updates;;
        3) restore_permissions;;
        4) check_permissions;;
        5) echo -e "${RED}Exiting script.${NC}"; exit;;
        *) echo -e "${RED}Invalid choice. Please enter a number from 1 to 5.${NC}"; display_menu;;
    esac
}

# Main script execution
display_menu

echo "-------------------"
echo -e "${GREEN}Script Completed.${NC}"
echo "-------------------"
