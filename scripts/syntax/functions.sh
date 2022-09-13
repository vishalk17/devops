#!/bin/bash

# server name
servername=$(hostname)

echo " current server name is : $servername"

# defining the function for checking ram usage
function memory_check() {
        echo " checking memory of $servername"
        echo ""
        free -mh
        echo ""
}

# check the disk usage currently files in the directory occupying

function disk_usage_check() {
        echo " checking occupying space of current directory"
        echo ""
        du -sh
        echo ""
}

# check cpu load
function cpu_load_check() {
        echo " checking cpu load"
        echo ""
        uptime
        echo ""
}

# check os and linux kernel version
function os_and_kernel_check() {
        echo " checking os and linux kernel version"
        echo ""
        echo " operating system"
        uname
        echo " kernel version "
        uname -r
        echo ""
}

# calling all functions

function all_checks() {
        memory_check
        disk_usage_check
        os_and_kernel_check
}

all_checks
