mkdir logs
mkdir logs/database
chmod 777 -R  logs
mkdir data
mkdir data/elastic 
mkdir data/elastic_snapshots
mkdir data/mysql
chmod 777 -R  data

sed -i '/ADVERTISED_URL/d' ./.env
echo 'ADVERTISED_URL=http://ott-adelph-dev/' >> ./.env