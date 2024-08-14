## Purpose: Manage configuration files using Git for multiple servers.

### Features:

- Backup: Copies local configuration files to a Git repository preserving their permissions, group, and user.
- Update / Restore: Pulls updates / restore from the repository and applies them to the system.
- Version Control: Tracks changes to configuration files located in various system directories using Git.

### Use Cases:

    - Track and version, multiple configuration files in Git.
    - Backup configuration files (useful if someone accidentally messes up and you need to restore them).