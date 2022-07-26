source components/common.sh

echo "Installing NGINX"
yum install nginx -y &>>$LOG_FILE
if [$? -eq 0 ]; then
  echo -e "\e[1;32m SUCCESS\e[0m"
else
  echo -e "\e[1;31m FAILED\e[0m"
  exit
fi

echo "Download the Frontend content"
curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" &>>$LOG_FILE

echo "Clean Old Content"
rm -rf /usr/share/nginx/html/* &>>$LOG_FILE

echo "Extracted Frontend Content"
cd /tmp
unzip -o frontend.zip &>>$LOG_FILE

echo "Copy Extracted Content to Nginx Path"
cp -r frontend-main/static/* /usr/share/nginx/html/ &>>$LOG_FILE

echo "Copy NGINX roboshop config"
cp frontend-main/localhost.conf /etc/nginx/default.d/roboshop.conf &>>$LOG_FILE

echo "Start NGINX Service"
systemctl enable nginx &>>$LOG_FILE
systemctl start nginx &>>$LOG_FILE