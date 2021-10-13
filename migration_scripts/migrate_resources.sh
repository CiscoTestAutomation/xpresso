
export ELASTIC=http://elasticsearch:9200
export RESULTS=http://results2:8000


echo "Migrating the resources to newer results format" 

node ./resources/migrations/results.js
