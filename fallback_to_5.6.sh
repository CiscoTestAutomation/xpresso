#Pre Step   changes  image of Mysql back to 5.6  in docker-compose.yml

if [ ! -d ./mysql_backup ] 
then
    echo "mysql_backup  dir doesnt exists, You missed  to take up the backup"
    exit 1 
fi

#step 1  Stopping the database  if it is already running
echo " Stop the database if running"
docker-compose  stop database

#Step 2 Remove the data/mysql/* 
echo "Remove the data from mysql/"
rm  -rf data/mysql/*

#Step 2   Copy the backup data again to  data/mysql
echo "copy the data from backup"
cp -rf mysql_backup/  data/mysql/

#start the database container
docker-compose up -d database

