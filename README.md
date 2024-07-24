 # DevOpsFetch

`DevOpsFetch` is a tool designed to collect and display system information, including active ports, user logins, Nginx configurations, Docker images, and container statuses. It also includes a systemd service to continuously monitor and log these activities.

## Installation and Configuration

### Prerequisites

Ensure you have the following dependencies installed on your system:
- Docker
- Nginx
- systemd

### Installation

1. Clone the repository:
    ```bash
    git clone https://github.com/yourusername/devopsfetch.git
    ```
  
2) Make the script executable:
     ```bash
     chmod +x devopsfetch.sh
    ```

3. Run the installation script to set up necessary dependencies and systemd service:
    ```bash
     sudo ./install.sh
    ```

### Configuration

You may need to edit configuration files based on your system setup. Refer to the comments in the script for more details.

## Usage

Run the `devopsfetch` tool with the following command-line options:

### Help
Display usage instructions:
```bash
devopsfetch -h
```
### Ports
Display all active ports and services:
```bash
devopsfetch -p
```
Display detailed information about a specific port:
```bash
devopsfetch -p <port_number>
```
### Docker
List all Docker images and containers:
```bash
devopsfetch -d
```
Provide detailed information about a specific container:
```bash
devopsfetch -d <container_name>
```
### Nginx
Display all Nginx domains and their ports:
```bash
devopsfetch -n
```
Provide detailed configuration information for a specific domain:
```bash
devopsfetch -n <domain>
```
### Users
List all users and their last login times:
```bash
devopsfetch -u
```
Provide detailed information about a specific user:
```bash
devopsfetch -u <username>
```
### Time Range
Display activities within a specified time range:
```bash
devopsfetch -t 'YYYY-MM-DD HH:MM:SS' 'YYYY-MM-DD HH:MM:SS'
```
### Logging Mechanism
DevOpsFetch includes a `systemd` service for continuous monitoring and logging. Logs are rotated and managed to ensure efficient storage usage.

### Log Location
Logs are stored in the `/var/log/devopsfetch/` directory. Each activity is logged with a timestamp for easy tracking.

### Retrieving Logs
To view the logs, you can use `journalctl` or any other log viewing tool:
```bash
sudo journalctl -u devopsfetch.service
```
Logs can also be viewed directly from the log file:
```bash
less /var/log/devopsfetch/devopsfetch.log
```
### Log Rotation
Logs are rotated based on size and time to prevent excessive disk usage. This is managed by the logrotate utility, which is configured during installation.

### Contributing
We welcome contributions! Please read our CONTRIBUTING.md for guidelines on how to get involved.






