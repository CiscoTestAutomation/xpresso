# xpresso-docker

This repo houses components needed to build and run Cisco Xpresso dashboard. 

## Prerequisites
* Have Docker and docker-compose installed on your system

## Docker Tags

* `vX.Y`: These are release builds published every month. X referes to year and Y refers to month, e.g., v20.4 or v19.12
* `latest`: These are the latest release builds. 

## Clone Repo
* git clone this repo to a custom dir


## Setup

The only mandatory argument required to setup Xpresso is `ADVERTISED_URL` which has to be the full proper URL the server is at, e.g., `http://xpresso.cisco.com/`. 

### Customizations
* At file `${BASE_DIR}/.env` set proper value for ADVERTISED_URL, INSTANCE_ID and TOOL_NAME.
* Under `${BASE_DIR}/env` there are places for further modifications as follows:
* * databases.env for the mysql root password.
* * elasticsearch.env for custom changes on the elasticsearch cluster.
* Create a dir under data dir at: `${DATA_DIR}/elastic`
* * Make the elastic data dir writable: `chmod -R 777 ${DATA_DIR}/elastic`.
* Double check that ``wait-for-it.sh`` script is executable. If not, run ``chmod +x wait-for-it.sh``. 
* Give write permission to mysql logs dir at the host. i.e., ``chmod -R 777 ${LOGS_DIR}/database``. 
* At file `${BASE_DIR}/.env` make sure DATA_DIR and LOGS_DIR have proper values and pointing to your desired locations.
* * BASE_DIR is where all contents of this repo reside (etc/, env/, initializers/, .env, and docker-compose.yml). Default to current location (cloned repo dir). 
* * DATA_DIR should be somewhere with sufficient disk space for Xpresso data.
* * LOGS_DIR should be somewhere with sufficient disk space for Xpresso microservices logs.
* [ WARNING ]: in linux servers, uncomment the `/etc/localtime:/etc/localtime:ro` and `/etc/timezone:/etc/timezone:ro` entries under volumes for all services.
* [ OPTIONAL ]: at file `${BASE_DIR}/.env`, change `TAG` to most appropriate value for your Xpresso instance.
* [ OPTIONAL ]: by default no ports are exposed in Docker. For your testing purposes, you can uncomment the ``ports`` entry in `docker-compose.yml` file for the services you want. 


### Start
* ``docker-compose pull``
* ``docker-compose up -d``


## Login

Xpresso will automatically creates a default admin user at startup. Use the username / password ``admin/admin`` to login to the dashboard with full administrator privileges.

By default, CISCO LDAP is disabled. Go to system management settings (from UI) and update those settings accordingly to allow Cisco user log in. 


## Building Images

Build script is only available for internal users and the ones who have access to the repo can run the script. In order for the script to push images to public docker hub, first login to docker using your credentials ``docker login``. However, you also need permissions to push into the ``ciscotestautomation`` private repository. 


## HTTPS

For SSL support you need to provide the ssl certificates (.key and .pem files) in order to update Nginx settings to reflect these changes. 

Put the .key and .pem files under `${BASE_DIR}/etc/` and uncomment in the `${BASE_DIR}/etc/nginx.conf` on the entrypoints 'ssl_certificate'. 

<!-- * To disable `setup nginx -ssl off` or to enable ssl `setup nginx -ssl on` -->

