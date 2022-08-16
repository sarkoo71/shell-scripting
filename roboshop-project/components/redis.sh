source components/common.sh

#Redis is used for in-memory data storage and allows users to access the data over API.
#**Manual Installation of Redis.**
#1. Install Redis.
#
#```bash
#
## curl -L https://raw.githubusercontent.com/roboshop-devops-project/redis/main/redis.repo -o /etc/yum.repos.d/redis.repo
## yum install redis-6.2.7 -y
#```
#
#2. Update the `bind` from `127.0.0.1` to `0.0.0.0` in config file `/etc/redis.conf` & `/etc/redis/redis.conf`
#
#3. Start Redis Database
#
#```bash
## systemctl enable redis
## systemctl start redis
#```

echo "Configuring redis repo"
curl -L https://raw.githubusercontent.com/roboshop-devops-project/redis/main/redis.repo -o /etc/yum.repos.d/redis.repo &>>$LOG_FILE
STAT $?

echo "Install Redis"
yum install redis-6.2.7 -y &>>LOG_FILE
STAT $?

echo "Update redis configuration"
if [ -f  /etc/redis.conf ]; then
    sed -i -e "s/127.0.0.1/0.0.0.0/g" /etc/redis.conf &>>$LOG_FILE
elif [ -f /etc/redis/redis.conf ]; then
    sed -i -e "s/127.0.0.1/0.0.0.0/g" /etc/redis/redis.conf &>>$LOG_FILE
fi
STAT $?

echo "Start Redis"
systemctl enable redis &>>$LOG_FILE
systemctl start redis &>>$LOG_FILE
STAT $?
