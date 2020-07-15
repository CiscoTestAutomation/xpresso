# pyATS Web Dashboard: XPRESSO

Designed to streamline your network automation, test and validation experience, 
XPRESSO is the standard pyATS UI dashboard that manages your test suites, test 
resources and test results, providing insights to your network through Cisco 
pyATS. 

The content of this repository is to help users with one-click deployment of 
XPRESSO inside their lab/networks.

## General Information

- Website: https://developer.cisco.com/pyats/
- Documentation: https://developer.cisco.com/docs/pyats/
- Support: pyats-support-ext@cisco.com

## EULA

XPRESSO is available for you, free to use, under the standard Apache 2.0 license
(see `LICENSE` file for details).

In addition you agree to the follow terms and conditions:

XPRESSO was primarily developed as an in-house UI dashboard for Cisco
engineering - and then made available to our customers, you, free of charge,
and as a value-add to our products. The development team did their best to make
the system modular and componentized, independent of Cisco internal tooling.

If you do find, during your usage, oversights & bugs, please kindly report
to us at pyats-support-ext@cisco.com.

> XPRESSO does not collect user statistics, and will not send telemetry of user
> information back to Cisco.

## Requirements

- Linux/macOS environment
- Docker installed and in working condition
- Free disk space for log storage
- Minimum System Spec:
    - 4 CPU (with hyper-threading)
    - 16G memory
- Ideal System Spec:
    - 12 CPU
    - 64G memory

Note: lower system spec will result in a much longer initial boot-up time. 

## Deployment

XPRESSO is developed using a micro-services architecture, with the services 
spanning over multiple docker containers, and the overall access achieved 
through a gateway that processes the APIs and distributes them to the services.

This repository helps with deploying and setting up your XPRESSO instance with
just a few clicks.

**1. Clone This Repository**
```bash
# in this example, we'll put everything under /workspace/xpresso
# you may choose your own home location
mkdir /workspace
cd /workspace
git clone https://github.com/CiscoTestAutomation/xpresso
```

**2. Customization**

The default set of settings should work for most users, with out of the box URL
set to http://localhost/. Eg - you can only access XPRESSO on this localhost.

To make the instance available for other users on your network to access, modify
the `.env` file and set the `ADVERTISED_URL` to the full, proper URL of this
server, eg, `http://xpresso.yourdomain.com/`.

* `BASE_DIR` is where all contents of this repo reside (`etc/`, `env/`, `initializers/`, `.env`, and `docker-compose.yml`). Default to current location (cloned repo dir). 
* At file `${BASE_DIR}/.env` set proper value for `ADVERTISED_URL`, `INSTANCE_ID` and `TOOL_NAME`.
* Under `${BASE_DIR}/env` there are places for further modifications as follows:
  * `databases.en`v for the mysql root password.
  * `elasticsearch.env` for custom changes on the elasticsearch cluster.
* Create a dir under data dir at: `${DATA_DIR}/elastic`
  * Make the elastic data dir writable: `chmod -R 777 ${DATA_DIR}/elastic`.
* Double check that `wait-for-it.sh` script is executable. If not, run `chmod +x wait-for-it.sh`. 
* Give write permission to mysql logs dir at the host. i.e., `chmod -R 777 ${LOGS_DIR}/database`. 
* At file `${BASE_DIR}/.env` make sure `DATA_DIR` and `LOGS_DIR` have proper values and pointing to your desired locations.
  * `DATA_DIR` should be somewhere with sufficient disk space for XPRESSO data.
  * `LOGS_DIR` should be somewhere with sufficient disk space for XPRESSO micros-ervices logs.
* [ WARNING ]: in linux servers, uncomment the `/etc/localtime:/etc/localtime:ro` and `/etc/timezone:/etc/timezone:ro` entries under volumes for all services.
* [ OPTIONAL ]: at file `${BASE_DIR}/.env`, change `TAG` to most appropriate value for your XPRESSO instance.
* [ OPTIONAL ]: by default no ports are exposed in Docker. For your testing purposes, you can uncomment the `ports` entry in `docker-compose.yml` file for the services you want. 

**3. Start Your Engine**

You're good to go:
```bash
# pull the latest images
docker-compose pull

# fire all cylinders
docker-compose up -d
```

## Administrator Login

XPRESSO will automatically creates a default `admin` user at startup.
Use the username/password `admin/admin` to login to the dashboard with full 
administrator privileges.

You may register more users into the internal database after you login as the
administrator.


## HTTPS

For HTTPS hosting, you need to provide the SSL certificates (.key and .pem files) 
and update NGINX settings to reflect these changes. 

Put the .key and .pem files under `${BASE_DIR}/etc/` and update 
`${BASE_DIR}/etc/nginx.conf` accordingly.

## User Documentation

Once XPRESSO is running, the full user documentation is available directly in 
the UI.