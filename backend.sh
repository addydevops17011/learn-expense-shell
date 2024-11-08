echo -e "\e[32m Disable nodejs module \e[0m"
dnf module disable nodejs -y
echo "exit status is - $?"

echo -e "\e[32m Enable nodejs:20 module \e[0m"
dnf module enable nodejs:20 -y
echo "exit status is - $?"

echo -e "\e[32m Install nodejs \e[0m"
dnf install nodejs -y
echo "exit status is - $?"

echo -e "\e[32m Create expense user \e[0m"
useradd expense
echo "exit status is - $?"

echo -e "\e[32m Copy backend.service to systemd directory \e[0m"
cp backend.service /etc/systemd/system/backend.service
echo "exit status is - $?"

echo -e "\e[32m Create /app directory \e[0m"
mkdir /app
echo "exit status is - $?"

echo -e "\e[32m Download backend.zip \e[0m"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/expense-backend-v2.zip
echo "exit status is - $?"

echo -e "\e[32m Change to /app directory \e[0m"
cd /app
echo "exit status is - $?"

echo -e "\e[32m Unzip backend.zip \e[0m"
unzip /tmp/backend.zip
echo "exit status is - $?"

echo -e "\e[32m Change to /app directory \e[0m"
cd /app
echo "exit status is - $?"

echo -e "\e[32m Install npm dependencies \e[0m"
npm install
echo "exit status is - $?"

echo -e "\e[32m Install mysql \e[0m"
dnf install mysql -y
echo "exit status is - $?"

echo -e "\e[32m Initialize mysql database \e[0m"
mysql -h 172.31.31.183 -uroot -pExpenseApp@1 < /app/schema/backend.sql
echo "exit status is - $?"

echo -e "\e[32m Reload systemd daemon \e[0m"
systemctl daemon-reload
echo "exit status is - $?"

echo -e "\e[32m Enable backend service \e[0m"
systemctl enable backend
echo "exit status is - $?"

echo -e "\e[32m Restart backend service \e[0m"
systemctl restart backend
echo "exit status is - $?"