#!/bin/bash

# Specify the branch name for Git operations
BRANCH="vishalk17-server"  # Replace with your preferred branch name

# Define the list of paths to be copied
PATHS=(
    "/etc/mysql/mysql.cnf"
    "/etc/logrotate.d/jenkins"
    "/home/vishal/fluentd/enable"
)

# Ensure the script is run with sudo
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root (sudo)." >&2
    exit 1
fi

# Function to update the repository with local configuration files
update_repo() {
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
            echo "Warning: $src_path does not exist and will not be included." >&2
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

    git commit -m "$COMMIT_MESSAGE"

    # Push changes to the specified branch
    if git push origin "$BRANCH"; then
        echo "Changes pushed to branch $BRANCH successfully."
    else
        echo "Error pushing changes to branch $BRANCH." >&2
        exit 1
    fi
}

# Function to pull updates from the repository and prompt user to apply them
apply_updates() {
    script_dir=$(dirname "$0")
    cd "$script_dir" || exit 1

    # Pull the latest changes from the remote repository
    echo "Pulling latest updates from branch $BRANCH..."
    if ! git pull origin "$BRANCH"; then
        echo "Error pulling updates from branch $BRANCH." >&2
        exit 1
    fi

    # Prompt user to apply updates
    read -p "Apply updated files now? [y/n]: " apply_choice
    case $apply_choice in
        y|Y)
            echo "Applying updates..."
            # Copy the files to their respective paths
            for src_path in "${PATHS[@]}"; do
                dest_path=".${src_path}"
                if [ -e "$dest_path" ]; then
                    cp -rp "$dest_path" "$src_path"
                else
                    echo "Warning: $dest_path does not exist and cannot be applied." >&2
                fi
            done

            # Restore ownership and permissions information
            ownership_file="ownership.txt"
            if [ -e "$ownership_file" ]; then
                while IFS= read -r line; do
                    perms=$(echo "$line" | cut -d' ' -f1)
                    user=$(echo "$line" | cut -d' ' -f2)
                    group=$(echo "$line" | cut -d' ' -f3)
                    file=$(echo "$line" | cut -d' ' -f4-)
                    chmod "$perms" "$file"
                    chown "$user:$group" "$file"
                done < "$ownership_file"
            else
                echo "Warning: Ownership file $ownership_file does not exist and ownership cannot be restored." >&2
            fi
            ;;
        n|N)
            echo "Updates were pulled but not applied."
            ;;
        *)
            echo "Invalid choice. Updates were pulled but not applied."
            ;;
    esac
}

# Function to display menu and handle user choice
display_menu() {
    echo "Menu:"
    echo "1. Update repository with local configuration files"
    echo "2. Pull updates from repository and apply to system paths"
    echo "3. Exit"

    read -p "Enter your choice [1-3]: " choice
    case $choice in
        1) update_repo;;
        2) apply_updates;;
        3) echo "Exiting script."; exit;;
        *) echo "Invalid choice. Please enter a number from 1 to 3."; display_menu;;
    esac
}

# Main script execution
display_menu

echo "Script Completed."
