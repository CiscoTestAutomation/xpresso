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

# comment this for mac OS
# sed -i .bak '/ADVERTISED_URL/d' ./.env;

sed -i '/ADVERTISED_URL/d' ./.env;
echo "ADVERTISED_URL=$1" >> ./.env;


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
echo -e "${YLW}Elasticsearch uses a mmapfs directory by default to store its indices. The default operating system limits on mmap counts is likely to be too low, which may result in out of memory exceptions. \nVisit: https://www.elastic.co/guide/en/elasticsearch/reference/master/_maximum_map_count_check.html${NC}";
echo -e "${RED}Writing 'sysctl -w vm.max_map_count=262144' to '/etc/sysctl.conf'${NC}";

while true; do
    read -p "Do you wish to edit /etc/sysctl.conf?" yn
    case $yn in
        [Yy]* ) sed -i .bak '/max_map_count/d' /etc/sysctl.conf; echo 'sysctl -w vm.max_map_count=262144' >> /etc/sysctl.conf; echo "file written"; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done


echo -e "${GREEN}Setup complete!${NC}";

echo -e "${GREEN}run: 'docker-compose up -d' to start xpresso.${NC}";

