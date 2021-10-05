source .env
source env/database.env



#first stepto update or add REDIS_AUTH

docker-compose exec -T requests curl -X PATCH -H "Content-Type: application/json" -d '{"CELERY_REDIS_PASSWORD":  "'"$REDIS_PASS"'"}'  http://management:8000/management/api/v1/settings/common

sleep 2

docker-compose exec -T requests curl -X PATCH -H "Content-Type: application/json" -d '{"CELERY_BROKER_PASSWORD": "'"$REDIS_PASS"'"}' http://management:8000/management/api/v1/settings/common

sleep 2

docker-compose exec -T requests  curl -X PATCH -H "Content-Type: application/json" -d '{"REDIS": {"DB":0, "PORT":6379, "password": "'"${REDIS_PASS}"'" ,"PASSWORD": "'"${REDIS_PASS}"'","HOST": "cache"}}' http://management:8000/management/api/v1/settings/common


docker-compose down
docker-compose down

echo  "Waiting for complete shutdown"

sleep 10

echo "Bringing Database up"

docker-compose up -d database cache elasticsearch

echo "Wait for Database up and running"

sleep 90 


docker-compose up -d management 

echo "Wait for management to be Up"

sleep  90

echo "Bringing up all remaining ones"
docker-compose up -d
