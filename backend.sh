# Source the common.sh file to import necessary variables and functions
source common.sh
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <password is missing>"
  exit 1
fi
# Install and configure the backend
Heading "Install and configure backend"

# Disable the nodejs module
dnf module disable nodejs -y &>>/tmp/expense.log
STAT $?

# Enable the nodejs module with version 20
dnf module enable nodejs:20 -y &>>/tmp/expense.log
STAT $?

# Install nodejs
dnf install nodejs -y &>>/tmp/expense.log
STAT $?

# Create a new user named 'expense'
Heading "Create expense user"
id expense &>>/tmp/expense.log
if [ $? -eq 0 ]; then
  echo "User already exists" >&2
else
  useradd expense
fi
STAT $?

# Copy the backend.service file to the systemd system directory
Heading "Copy backend service file"
cp backend.service /etc/systemd/system/backend.service
STAT $?

# Create a new directory named '/app'
Heading "Create app directory"
mkdir /app
STAT $?

# Download the backend zip file from the specified URL
Heading "Download backend zip file"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/expense-backend-v2.zip
STAT $?

# Change to the '/app' directory
cd /app
STAT $?

# Unzip the backend zip file
Heading "Unzip backend zip file"
unzip /tmp/backend.zip
STAT $?

# Install npm dependencies
Heading "Install npm dependencies"
npm install &>>/tmp/expense.log
STAT $?

# Install mysql
Heading "Install mysql"
dnf install mysql -y &>>/tmp/expense.log
STAT $?

# Initialize the mysql database with the backend schema
Heading "Initialize mysql database"
mysql -h 172.31.31.183 -uroot -p"$1" < /app/schema/backend.sql
STAT $?

# Reload the systemd daemon
Heading "Reload systemd daemon"
systemctl daemon-reload
STAT $?

# Enable the backend service
Heading "Enable backend service"
systemctl enable backend
STAT $?

# Restart the backend service
Heading "Restart backend service"
systemctl restart backend
STAT $?