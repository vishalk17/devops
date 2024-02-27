**Automate Script Execution on Remote Servers**

This Bash script automates the execution of scripts on remote servers via SSH. It reads server configuration details from a file and executes the specified script on each server. It can execute scripts concurrently on multiple servers.
Features

   -  Executes scripts on remote servers via SSH.
   -  Parallel execution of scripts for efficient operation.
   -  Supports reading server configuration from a customizable file.
   -  Provides logging of script execution output.

**Usage**

    Clone this repository:


Navigate to the script directory:


`cd remote-script-execution`


Modify the server_config.txt file to include details of your remote servers in the following format:


`<Server Alias> <Username> <IP Address> <Script Location> <Script Name> <Password>
`

Execute the script:


`bash automate_script_execution.sh
`

Optionally, you can specify a specific server alias to execute the script only on that server:


`bash automate_script_execution.sh <Server Alias>
`

Dependencies


    sshpass: Required for providing the password for SSH authentication.
    SSH access to remote servers configured with password authentication.


