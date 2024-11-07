echo "Installing Nginx"

dnf install nginx -y

echo "copy the expense.conf file"
cp /home/ec2-user/learn-expense-shell/expense.conf /etc/nginx/default.d/expense.conf

echo " remove the existing contents of /usr/share/nginx/html"
rm -rf /usr/share/nginx/html/*

echo "copy the frontend.zip file"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/expense-frontend-v2.zip
cd /usr/share/nginx/html

echo "unzip the frontend.zip file"
unzip /tmp/frontend.zip

echo "enable and start the nginx service"
systemctl enable nginx
systemctl restart nginx