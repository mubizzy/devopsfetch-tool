- # DevOpsFetch

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
    cd devopsfetch
    ```
  
2) Make the script executable:
    - ```bash
    - chmod +x devopsfetch.sh
    - ```

3. Run the installation script to set up necessary dependencies and systemd service:
    ```bash
    * sudo ./install.sh
    ```

### Configuration

You may need to edit configuration files based on your system setup. Refer to the comments in the script for more details.

## Usage

Run the `devopsfetch` tool with the following command-line options:

### Help
Display usage instructions:
```bash
devopsfetch -h
