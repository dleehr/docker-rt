RT with Postgres
================

Based on https://github.com/cloos/docker-rt-base and https://github.com/cloos/docker-rt

1. Edit docker-compose.yml to set a real database password (better yet move this to an encrypted secret)
2. Run `docker-compose up -d`. This starts postgres and builds the RT docker image
3. Run `./initdb.sh`. This simply runs a one off command inside the RT container that connects to postgres and creates tables. Use the password you provided in 1.
4. Visit http://localhost. Login with username "root" and password "password"
