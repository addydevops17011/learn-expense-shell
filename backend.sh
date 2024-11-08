# Source the common.sh file to import necessary variables and functions
source common.sh

# Install and configure the backend
Heading "Install and configure backend"

# Disable the nodejs module
dnf module disable nodejs -y
echo "exit status is - $?"

# Enable the nodejs module with version 20
dnf module enable nodejs:20 -y
echo "exit status is - $?"

# Install nodejs
dnf install nodejs -y
echo "exit status is - $?"

# Create a new user named 'expense'
Heading "Create expense user"
useradd expense
echo "exit status is - $?"

# Copy the backend.service file to the systemd system directory
Heading "Copy backend service file"
cp backend.service /etc/systemd/system/backend.service
echo "exit status is - $?"

# Create a new directory named '/app'
Heading "Create app directory"
mkdir /app
echo "exit status is - $?"

# Download the backend zip file from the specified URL
Heading "Download backend zip file"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/expense-backend-v2.zip
echo "exit status is - $?"

# Change to the '/app' directory
cd /app
echo "exit status is - $?"

# Unzip the backend zip file
Heading "Unzip backend zip file"
unzip /tmp/backend.zip
echo "exit status is - $?"

# Install npm dependencies
Heading "Install npm dependencies"
npm install
echo "exit status is - $?"

# Install mysql
Heading "Install mysql"
dnf install mysql -y
echo "exit status is - $?"

# Initialize the mysql database with the backend schema
Heading "Initialize mysql database"
mysql -h 172.31.31.183 -uroot -pExpenseApp@1 < /app/schema/backend.sql
echo "exit status is - $?"

# Reload the systemd daemon
Heading "Reload systemd daemon"
systemctl daemon-reload
echo "exit status is - $?"

# Enable the backend service
Heading "Enable backend service"
systemctl enable backend
echo "exit status is - $?"

# Restart the backend service
Heading "Restart backend service"
systemctl restart backend
echo "exit status is - $?"