echo -e "\e[32m install nginx \e[0m"

dnf install nginx -y

echo -e "\e[32m configure nginx \e[0m"
cp /home/ec2-user/learn-expense-shell/expense.conf /etc/nginx/default.d/expense.conf


echo -e "\e[32m download the frontend.zip file \e[0m"

rm -rf /usr/share/nginx/html/*


echo -e "\e[32m download the frontend.zip file \e[0m"

curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/expense-frontend-v2.zip
cd /usr/share/nginx/html


echo -e "\e[32m unzip the frontend.zip file \e[0m"
unzip /tmp/frontend.zip


echo -e "\e[32m start the nginx service \e[0m"
systemctl enable nginx
systemctl restart nginx