RED='\033[0;31m'
YLW='\033[0;33m'
BLUE='\033[0;34m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color


echo -e "ADVERTISED_URL: ${BLUE}$1${NC}";
[ -z "$1" ] && echo "ADVERTISED_URL not set. Enter the host url you would like to advertise." && exit;

while true; do
    read -p "Do you wish to continue? " yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

sed -i '/ADVERTISED_URL/d' ./.env
echo 'ADVERTISED_URL=$1' >> ./.env


echo 'Creating data and logs directory';

mkdir logs
mkdir logs/database
chmod 777 -R  logs
mkdir data
mkdir data/elastic
mkdir data/elastic_snapshots
mkdir data/mysql
chmod 777 -R  data

echo -e "${YLW}Warning:${NC}";
echo -e "${YLW}Elasticsearch uses a mmapfs directory by default to store its indices. The default operating system limits on mmap counts is likely to be too low, which may result in out of memory exceptions.${NC}";
echo -e "${RED}Writing 'sysctl -w vm.max_map_count=262144' to '/etc/sysctl.conf'${NC}";

while true; do
    read -p "Do you wish to continue?" yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

sed -i '/max_map_count/d' /etc/sysctl.conf
echo 'sysctl -w vm.max_map_count=262144' >> /etc/sysctl.conf

echo -e "${GREEN}Setup complete!${NC}";

echo -e "${GREEN}run: 'docker-compose up -d' to start xpresso.${NC}";

