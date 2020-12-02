docker pull ciscotestautomation/pyats-web-results:latest
docker-compose stop results
docker-compose start results
docker-compose exec results python manage.py generate_snapshot
mkdir -p logs/results2
mv logs/results/result_snapshot.json logs/results2/result_snapshot.json

# clean cache
mv data/archives/cached data/archives/cached_old
mkdir data/archives/cached
echo "Results service migrations done!"
