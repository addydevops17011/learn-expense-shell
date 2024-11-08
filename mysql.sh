source common.sh
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <password is missing>"
  exit 1
fi

# Print a message to indicate the start of mysql-server installation
Heading "Install and configure mysql-server"


# Install mysql-server without prompting for confirmation
dnf install mysql-server -y &>>/tmp/mysql-install.log
STAT $?

# Print a message to indicate the start of mysql-server service
Heading " Start mysql-server "


# Enable the mysql-server service to start at boot
systemctl enable mysqld &>>/tmp/mysql-service.log
STAT $?

# Start the mysql-server service
systemctl start mysqld &>>/tmp/mysql-service.log


# Print a message to indicate the start of mysql-server security configuration
Heading " Secure mysql-server "


# Secure the mysql-server by setting the root password
# The password is passed as a command-line argument ($1) ExpenseApp@1
mysql_secure_installation --set-root-pass $1 &>>/tmp/mysql-secure.log
STAT $?