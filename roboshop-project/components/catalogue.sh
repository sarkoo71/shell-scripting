#1. This service is written in NodeJS, Hence need to install NodeJS in the system.
#
#```bash
## curl -fsSL https://rpm.nodesource.com/setup_lts.x | bash -
## yum install nodejs gcc-c++ -y
#
#```
#
#1. Let's now set up the catalogue application.
#
#As part of operating system standards, we run all the applications and databases as a normal user but not with root user.
#
#So to run the catalogue service we choose to run as a normal user and that user name should be more relevant to the project. Hence we will use `roboshop` as the username to run the service.
#
#```bash
## useradd roboshop
#
#```
#
#1. So let's switch to the `roboshop` user and run the following commands.
#
#```bash
#$ curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip"
#$ cd /home/roboshop
#$ unzip /tmp/catalogue.zip
#$ mv catalogue-main catalogue
#$ cd /home/roboshop/catalogue
#$ npm install
#
#```
#
#1. Update SystemD file with correct IP addresses
#
#    Update `MONGO_DNSNAME` with MongoDB Server IP
#
#2. Now, lets set up the service with systemctl.
#
#```bash
## mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service
## systemctl daemon-reload
## systemctl start catalogue
## systemctl enable catalogue
#
#```
source components/common.sh

echo "Setup NodeJS Repo"
curl -fsSL https://rpm.nodesource.com/setup_lts.x | bash - &>>$LOG_FILE

echo "Install NodeJS"
yum install nodejs gcc-c++ -y &>>$LOG_FILE


echo "Create app user"
useradd roboshop &>>$LOG_FILE


echo "Download Catalogue code"
curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip" &>>$LOG_FILE

echo "Extract Catalogue Code"
cd /tmp/
unzip -o catalogue.zip &>>$LOG_FILE &>>$LOG_FILE

echo "Remove old catalogue"
rm -rf /home/roboshop/catalogue

echo "Copy catalogue content"
cp -r catalogue-main /home/roboshop/catalogue &>>$LOG_FILE

echo "Install NodeJS Dependencies"
cd /home/roboshop/catalogue
npm install &>>$LOG_FILE

echo "changing permission for user and group"
chown roboshop:roboshop /home/roboshop/ -R