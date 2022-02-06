#The frontend is the service in RobotShop to serve the web content over Nginx.
#
#To Install Nginx.
#
#```
## yum install nginx -y
## systemctl enable nginx
## systemctl start nginx
#
#```
#
#Let's download the HTDOCS content and deploy under the Nginx path.
#
#```
## curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip"
#
#```
#
#Deploy in Nginx Default Location.
#
#```
## cd /usr/share/nginx/html
## rm -rf *
## unzip /tmp/frontend.zip
## mv frontend-main/* .
## mv static/* .
## rm -rf frontend-master README.md
## mv localhost.conf /etc/nginx/default.d/roboshop.conf
#
#```
#
#Finally restart the service once to effect the changes.
#
#```
## systemctl restart nginx
#
#```
LOG_FILE=/tmp/roboshop.log
rm -f $LOG_FILE

echo "Installing NGINX"
yum install nginx -y &>>$LOG_FILE

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