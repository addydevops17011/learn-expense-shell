source common.sh

rm -f /tmp/expense.log


# Install and configure nginx
Heading "Install and configure nginx"
# Install nginx without prompting for confirmation
dnf install nginx -y &>>/tmp/expense.log

STAT $?

Heading "Configure nginx"
# Copy the expense.conf file to the nginx configuration directory
cp /home/ec2-user/learn-expense-shell/expense.conf /etc/nginx/default.d/expense.conf &>>/tmp/expense.log
STAT $?

# Remove existing files in the nginx html directory
rm -rf /usr/share/nginx/html/*

# Download the frontend zip file
Heading "Download the frontend zip file"
# Download the frontend zip file from the specified URL and save it to /tmp
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/expense-frontend-v2.zip &>>/tmp/expense.log
STAT $?

# Change to the nginx html directory
cd /usr/share/nginx/html

# Unzip the frontend zip file
Heading "Unzip the frontend zip file"
# Unzip the frontend zip file in the current directory
unzip /tmp/frontend.zip &>>/tmp/expense.log
STAT $?

# Start the nginx service
Heading "Start the nginx service"
# Enable the nginx service to start at boot
systemctl enable nginx &>>/tmp/expense.log
# Restart the nginx service
systemctl restart nginx &>>/tmp/expense.log
STAT $?
