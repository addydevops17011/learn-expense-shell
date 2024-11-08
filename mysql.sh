# Install and configure mysql-server

# Print a message to indicate the start of mysql-server installation
echo -e "\e[32m Install mysql-server \e[0m"
echo "Installing mysql-server..." >&2

# Install mysql-server without prompting for confirmation
dnf install mysql-server -y &>>/tmp/mysql-install.log
echo "Exit status of mysql-server installation: $?" >&2

# Print a message to indicate the start of mysql-server service
echo -e "\e[32m Start mysql-server \e[0m"
echo "Starting mysql-server service..." >&2

# Enable the mysql-server service to start at boot
systemctl enable mysqld &>>/tmp/mysql-service.log
echo "Exit status of mysql-server service enable: $?" >&2

# Start the mysql-server service
systemctl start mysqld &>>/tmp/mysql-service.log
echo "Exit status of mysql-server service start: $?" >&2

# Print a message to indicate the start of mysql-server security configuration
echo -e "\e[32m Secure mysql-server \e[0m"
echo "Securing mysql-server..." >&2

# Secure the mysql-server by setting the root password
# The password is passed as a command-line argument ($1) ExpenseApp@1
mysql_secure_installation --set-root-pass $1 &>>/tmp/mysql-secure.log
echo "Exit status of mysql-server security configuration: $?" >&2