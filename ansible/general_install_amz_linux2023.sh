#!/bin/bash

# Function to display usage information
usage() {
    echo "Usage: $0 {master|node}"
    echo "example : $0 master   ... for master node"
    exit 1
}

# Check if the script is run with root privileges
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root. Exiting..."
    exit 1
fi

# Check if a valid argument is provided
if [[ $# -ne 1 ]]; then
    usage
fi

# Determine the installation type based on the argument
INSTALL_TYPE=$1

# Function for common installation steps
common_installation() {
    ## Install required packages ##
    echo "Installing required packages..."
    yum install -y ansible git
    sleep 4

    ### Add user with password start ###
    echo "Adding ansible user with specified password..."
    useradd -m ansible
    echo "ansible:ansible" | chpasswd

    ### Provide ansible user with root privileges start ###
    echo "Granting sudo privileges to ansible user..."
    echo 'ansible ALL=(ALL)       NOPASSWD: ALL' >> /etc/sudoers

    ### Edit SSH configuration start ###
    echo "Modifying SSH configuration..."
    sed -i "s%#PermitRootLogin prohibit-password%PermitRootLogin yes%g" /etc/ssh/sshd_config
    sed -i "s%PasswordAuthentication no%PasswordAuthentication yes%g" /etc/ssh/sshd_config

    echo "Restarting SSH service..."
    service sshd restart
}

# Function for Ansible master installation
master_installation() {
    common_installation

    ### Configure Ansible start ###
    echo "Configuring Ansible..."
    ansible-config init --disabled -t all > ~/.ansible/ansible.cfg  # Create ansible.cfg
    sed -i "s%;inventory=/etc/ansible/hosts%inventory=/etc/ansible/hosts%g" ~/.ansible/ansible.cfg
    sed -i "s%;become_user=root%become_user=root%g" ~/.ansible/ansible.cfg
}

# Function for Ansible node installation
node_installation() {
    common_installation
}

# Execute the appropriate function based on the argument
case $INSTALL_TYPE in
    master)
        master_installation
        ;;
    node)
        node_installation
        ;;
    *)
        usage
        ;;
esac

