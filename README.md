Steps to Configure:-

1. Install Docker and Docker Compose
2. docker compose -f docker-compose-superset.yml build --no-cache
3. docker compose -f docker-compose-superset.yml up -d
4. # Create admin user
docker exec -it superset_app superset fab create-admin \
    --username admin \
    --firstname Admin \
    --lastname User \
    --email admin@example.com \
    --password admin

# Run DB migrations
docker exec -it superset_app superset db upgrade

# Load examples (optional)
docker exec -it superset_app superset load_examples

# Initialize
docker exec -it superset_app superset init
