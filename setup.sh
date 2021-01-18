echo "ADVERTISED_URL: $1";
[ -z "$1" ] && echo "ADVERTISED_URL not set. Enter the host url you would like to advertise." && exit;

while true; do
    read -p "Do you wish to continue? " yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

mkdir logs
mkdir logs/database
chmod 777 -R  logs
mkdir data
mkdir data/elastic
mkdir data/elastic_snapshots
mkdir data/mysql
chmod 777 -R  data

sed -i '/ADVERTISED_URL/d' ./.env
echo 'ADVERTISED_URL=$1' >> ./.env

sed -i '/max_map_count/d' /etc/sysctl.conf
echo 'sysctl -w vm.max_map_count=262141' >> /etc/sysctl.conf

