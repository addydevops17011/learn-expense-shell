# Install and configure nginx
echo -e "\e[32m Install nginx \e[0m"
# Install nginx without prompting for confirmation
dnf install nginx -y

echo -e "\e[32m Configure nginx \e[0m"
# Copy the expense.conf file to the nginx configuration directory
cp /home/ec2-user/learn-expense-shell/expense.conf /etc/nginx/default.d/expense.conf

# Remove existing files in the nginx html directory
rm -rf /usr/share/nginx/html/*

# Download the frontend zip file
echo -e "\e[32m Download the frontend.zip file \e[0m"
# Download the frontend zip file from the specified URL and save it to /tmp
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/expense-frontend-v2.zip

# Change to the nginx html directory
cd /usr/share/nginx/html

# Unzip the frontend zip file
echo -e "\e[32m Unzip the frontend.zip file \e[0m"
# Unzip the frontend zip file in the current directory
unzip /tmp/frontend.zip

# Start the nginx service
echo -e "\e[32m Start the nginx service \e[0m"
# Enable the nginx service to start at boot
systemctl enable nginx
# Restart the nginx service
systemctl restart nginx