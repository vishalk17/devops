#!/bin/bash

# Define the date and time format in IST
current_date=$(TZ=Asia/Kolkata date +'%d-%m-%Y-%H-%M-%S-IST-time')
folder_name="$current_date"
mkdir -p "$folder_name"

# Read server configuration from a file (server_config.txt)
server_config_file="server_config.txt"

# Function to execute a script on a remote server using SSH
execute_remote_script() {
  local server_alias="$1"
  local server_username="$2"
  local server_ip="$3"
  local script_location="$4"
  local script_name="$5"
  local password="$6"
  
  # Print a status message indicating which server is being processed
  echo "Executing on $server_alias ($server_ip)"
  
  # Execute the remote script on the server using sshpass and run it in the background
  log_file="${folder_name}/${server_alias}-${current_date}.log"
  sshpass -p "$password" ssh -o ConnectTimeout=10 "$server_username"@"$server_ip" "bash '$script_location/$script_name'" > "$log_file" 2>&1 &
}

# Function to wait for all background processes to finish
wait_for_background_processes() {
  wait
}

# Check if a specific server alias is provided as an argument
specific_server="$1"

if [ -z "$specific_server" ]; then
  # No specific server alias provided, execute for all servers
  while read -r line; do
    server_alias=$(echo "$line" | awk '{print $1}')
    server_username=$(echo "$line" | awk '{print $2}')
    server_ip=$(echo "$line" | awk '{print $3}')
    script_location=$(echo "$line" | awk '{print $4}')
    script_name=$(echo "$line" | awk '{print $5}')
    password=$(echo "$line" | awk '{print $6}')
    
    # Execute the remote script on the server in parallel and print status
    execute_remote_script "$server_alias" "$server_username" "$server_ip" "$script_location" "$script_name" "$password"
  done < "$server_config_file"
  
  # Wait for all background processes to finish
  wait_for_background_processes
else
  # A specific server alias is provided, execute only for that server
  while read -r line; do
    server_alias=$(echo "$line" | awk '{print $1}')
    if [ "$server_alias" == "$specific_server" ]; then
      server_username=$(echo "$line" | awk '{print $2}')
      server_ip=$(echo "$line" | awk '{print $3}')
      script_location=$(echo "$line" | awk '{print $4}')
      script_name=$(echo "$line" | awk '{print $5}')
      password=$(echo "$line" | awk '{print $6}')
      
      # Execute the remote script on the specific server and print status
      execute_remote_script "$server_alias" "$server_username" "$server_ip" "$script_location" "$script_name" "$password"
      break
    fi
  done < "$server_config_file"
fi

###############################

echo ""
echo "script completed $0"

