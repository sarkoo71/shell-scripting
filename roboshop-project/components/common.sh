LOG_FILE=/tmp/roboshop.log
rm -f $LOG_FILE

STAT(){
  if [ $1 -eq 0 ]; then
    echo -e "\e[1;32m SUCESS\e[0m"
  else
    echo -e "\e[1;31m FAILED\e[0m"
    exit 2
  fi
}



NODEJS(){
  COMPONENT=$1
  echo "Setup NodeJS Repo"
  curl -fsSL https://rpm.nodesource.com/setup_lts.x | bash - &>>$LOG_FILE
  STAT $?

  echo "Install NodeJS"
  if
  yum install nodejs -y&>>$LOG_FILE
  STAT $?

  echo "Create app user"
  useradd roboshop &>>$LOG_FILE
  STAT $?

  echo "Download ${COMPONENT}   code"
  curl -s -L -o /tmp/${COMPONENT}.zip "https://github.com/roboshop-devops-project/${COMPONENT}/archive/main.zip" &>>$LOG_FILE
  STAT $?

  echo "Extract ${COMPONENT} Code"
  cd /tmp/
  unzip -o ${COMPONENT}.zip &>>$LOG_FILE
  STAT $?

  echo "Remove old User"
  rm -rf /home/roboshop/${COMPONENT}
  STAT $?

  echo "Copy ${COMPONENT} content"
  cp -r ${COMPONENT}-main /home/roboshop/${COMPONENT} &>>$LOG_FILE
  STAT $?

  echo "Install NodeJS Dependencies"
  cd /home/roboshop/${COMPONENT}
  npm install &>>$LOG_FILE
  STAT $?

  echo "changing permission for user and group"
  chown roboshop:roboshop /home/roboshop/ -R &>>$LOG_FILE
  STAT $?

  echo "Updating ${COMPONENT} systemD file"
  sed -i -e 's/MONGO_DNSNAME/mongod.rshope.internal/' /home/roboshop/${COMPONENT}/systemd.service &>>$LOG_FILE
  STAT $?

  echo "Setup ${COMPONENT} Systemd File"
  mv /home/roboshop/${COMPONENT}/systemd.service /etc/systemd/system/${COMPONENT}.service &>>$LOG_FILE
  STAT $?

  echo "start ${COMPONENT} Service"
  systemctl daemon-reload &>>$LOG_FILE
  systemctl enable ${COMPONENT} &>>$LOG_FILE
  systemctl start ${COMPONENT} &>>$LOG_FILE
  STAT $?
}