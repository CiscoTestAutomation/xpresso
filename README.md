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

All we ask is that if you be patient with us, and if you find, during your usage, 
oversights & bugs, please kindly report to us at pyats-support-ext@cisco.com, and 
optionally work with the team to identify, classify and/or verify the fix. 

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


## Migration steps
- [Steps to upgrade to v20.12](https://github.com/CiscoTestAutomation/xpresso/wiki/How-to-upgrade-XPRESSO-to-v20.12)
- [Steps to upgrade to v21.1](https://github.com/CiscoTestAutomation/xpresso/wiki/How-to-upgrade-XPRESSO-to-v21.1)


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

**2. Initializations**

The default set of settings should work for most users, with out of the box URL
set to http://localhost/. Eg - you can only access XPRESSO on this localhost.

To make the instance available for other users on your network to access, modify
the `.env` file and set the `ADVERTISED_URL` to the full, proper URL of this
server, eg, `http://xpresso.yourdomain.com/`.

* `BASE_DIR` is where all contents of this repo reside (`etc/`, `env/`, `initializers/`, `.env`, and `docker-compose.yml`). Default to current location (cloned repo dir). 
* At file `${BASE_DIR}/.env` set proper value for `ADVERTISED_URL`, `INSTANCE_ID` and `TOOL_NAME`.
* Under `${BASE_DIR}/env` there are places for further modifications as follows:
  * `databases.env` for the mysql root password, and Xpresso's database user `xpresso_admin` and its password. 
  * `elasticsearch.env` for custom changes on the elasticsearch cluster.
* Make sure `xpresso_admin` password is the same across all these files
  * `env/databases.env`
  * `initializers/docker-entrypoint-initdb.d/1-user.sql`
  * `initializers/settings.yml`
  * `etc/mgmt_settings.py`
* If you have updated `xpresso_admin` password from UI, update the password in the `initializers/new_settings.yml` as well.
* Create a dir under data dir at: `${DATA_DIR}/elastic`
  * Make the elastic data dir writable: `chmod -R 777 ${DATA_DIR}/elastic`.
* Double check that `wait-for-it.sh` script is executable. If not, run `chmod +x wait-for-it.sh`. 
* Give write permission to mysql logs dir at the host. i.e., `chmod -R 777 ${LOGS_DIR}/database`. 
* At file `${BASE_DIR}/.env` make sure `DATA_DIR` and `LOGS_DIR` have proper values and pointing to your desired locations.
  * `DATA_DIR` should be somewhere with sufficient disk space for XPRESSO data.
  * `LOGS_DIR` should be somewhere with sufficient disk space for XPRESSO micros-ervices logs.
  
* [ WARNING ]: in linux servers, make sure the max_map_count is set to at *least* 262144, ie `vm.max_map_count=262144`. See [elastic documentation](https://www.elastic.co/guide/en/elasticsearch/reference/current/vm-max-map-count.html) for details.
* [ WARNING ]: in linux servers, uncomment the `/etc/localtime:/etc/localtime:ro` entries under volumes for all services to ensure timezone Xpresso uses matches your host.
* [ OPTIONAL ]: at file `${BASE_DIR}/.env`, change `TAG` to most appropriate value for your XPRESSO instance.
* [ OPTIONAL ]: by default no ports are exposed in Docker. For your testing purposes, you can uncomment the `ports` entry in `docker-compose.yml` file for the services you want. 

* **Important**: Adding new settings or updating existing ones should be done through `initializers/new_settings.yml` file. Once done, restart ``management`` service and your setting will be updated right away. 
Remember: you may also need to restart all other service which are supposed to use the new/update settings. 


**3. Custom LDAP Configuration (optional)**

XPRESSO supports multiple LDAP authentication, by allowing you provide a list of ldap configurations. To enable this:

* In `initializers/new_settings.yml`, under `common`, add/modify an extra setting `LDAP_CONFIG` with the value being a list of configurations for:
  * `LDAP_DESCRIPTION` e.g. ABC Organization LDAP
  * `GEN_USER` e.g. gen_username
  * `SEARCH_SCOPE` e.g. SUBTREE | BASE | LEVEL
  * `LDAP_PROTOCOL` e.g. LDAP
  * `LDAP_SOURCE` e.g. ABC
  * `LDAP_NAME` e.g. ABC LDAP Auth
  * `LDAP_HOST` e.g. internal.abc.com
  * `SEARCH_FILTER` e.g. (uid={USER})
  * `GEN_PASS` e.g. gen_password
  * `SEARCH_BASE` e.g. o=internal.abc.com
  * `SEARCH_ATTRIBUTES` e.g. ["cn", "givenName", "title", "mail"]

* In same file `initializers/new_settings.yml`, under `microservices` add (if not exists) `auths` service and modify your `AUTHENTICATION_BACKENDS` to include `authms.backends.CustomLDAPBackend`

* Finally, for LDAP search, in same file `initializers/new_settings.yml`, search under `microservices` for `users` and add:
  * `SEARCH_BACKENDS`: ["user_profiles.backends.CustomLDAPSearch"]

* When updating microservices' settings, make sure to include `url` and `description` as well. To make sure you're not making a mistake, you can copy each service's settings from `initializers/settings.yml` file and modify at new_settings.yml

* Restart the management service `docker-compose restart management`, in order to reflect the changes.

**Important**: whatever is set in `initializers/new_settings.yml` will overwritte the initial settings. 

**4. Start Your Engine**

You're good to go:
```bash
cd /workspace/xpresso

# pull the latest images
docker-compose pull

# fire all cylinders
docker-compose up -d
```

You should be able to access XPRESSO now at http://localhost/. Enjoy!

> It may take a while for the initial settings to be automatically applied while
> the system boots for the first time. This may mean you could not login using
> the default credentials for a few minutes. Give it some time (eg, 5-10min on
> a 2016 MacBook Pro 15)

**5. New Xpresso Worker \[optional\]**
New Xpresso worker (v20.11) has a lot of improveoments over the older versions. If you're willing to upgrade your Xpresso to version v20.11, you need to make sure `Worker` data directory is correct. 
Just verify that workers data directory is located at `${BASE_DIR}/data/workers`. 


**6. Email and SMTP \[optional\]**

Add or modify `initializers/new_settings.yml` under `common` section to suit your email server to enable XPRESSO to send emails. This is used for user signup / management, automated notifications of runs and reservations, and sending of result reports.

``` yaml
EMAIL_HOST: 'my-smtp-server'
EMAIL_PORT: 25
EMAIL_HOST_USER: 'username'
EMAIL_HOST_PASSWORD: 'passwd',
EMAIL_USE_TLS: true, // or remove
EMAIL_USE_SSL: true, // or remove
EMAIL_TIMEOUT: 10000
EMAIL_SSL_KEYFILE: '/path/to/pem', // or remove
EMAIL_SSL_CERTFILE: '/apth/to/pem' // or remove
```

**Important**: Adding new settings or updating existing ones should be done through `initializers/new_settings.yml` file. Once done, restart ``management`` service and your setting will be updated right away. 
Remember: you may also need to restart all other service which are supposed to use the new/update settings. 


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

## Data & Logs

By default, all your data and services logs are stored under `./data/` (e.i., `DATA_DIR`) and
 `./logs/` (i.e., `LOGS_DIR`) directory, including database files, archives uploaded, etc. To
 wipe the server and "start from scratch" again, just delete these folders.
 
 No data is saved in the containers - everything is volume mounted to disk.


## Common Issues, Questions & Answers

**Unhealthy services**

If you run ``docker-compose ps`` or ``docker ps`` and see any unlealthy services, first check the logs ``docker-compose logs -f <service-name>`` or ``<LOGS_DIR>/<service-name>``. If logs are not informative, you can restart the service: ``docker-compose stop <service-name> && docker-compose up -d <service-name>``. 

**Why are there references (eg, in logs) to S3?**

Initially XPRESSO was called S3, with the number 3 being a superscript 
(eg, S-cubed), short for "self-serving-services". As this confused some folks 
with Amazon S3 services, we renamed the pyATS web dashboard service to XPRESSO,
expressing our love for coffee.

**Error: No Resources Found**

This occurs when the resource management service did not boot up properly. It
happens usually when the server you are launching on is a bit slow. Try the 
following:

```bash
docker-compose restart resources
```
The problem should go away. 

**Cannot Login using default `admin/admin`**

Wait a bit more, or `docker-compose restart users auths`. The initial bootup 
performs a lot of first-start settings and database migrations, and could fail
due to running on a slow server.

**ElasticSearch failure to start**

Please check the logs using `docker-compose logs elasticsearch`. If it complains
about permission issues, run: `chmod 777 data/elastic` and restart elastic using
`docker-compose restart elasticsearch`.
Also, make sure you've run this: `sysctl -w vm.max_map_count=262144`. 

**Cannot connect to database**

If services are failing to start, and logs show that they cannot connect to 
database at `database:3306`, make sure your firewalls are not blocking the 
bridge network `192.168.66.0/24`.


**General networking issues with Xpresso install**
* Ensure hostname is properly set and resolvable both internally and externally to the host machine
* Ensure DNS on the host is configured to be able to resolve its external hostname and IP
* Ensure the `ADVERTISED_URL` in the `.env` file is set to the fully qualified external URL using hostname or IP *not localhost*
* Ensure if a proxy is set, it does not affect traffic going to the above domain/hostname
* Ensure nothing else is using or restricting the local `192.168.66.x` subnet (or change it to another one)
* Ensure to switch off the Firewall: For CENTOS - `sudo systemctl stop firewalld` , Ubuntu - `sudo ufw disable`

As a trial - shutdown xpresso `docker-compose down`, turn off your firewall, 
restart docker service, and try starting xpresso again.

See: https://github.com/CiscoTestAutomation/xpresso/wiki#how-to-test-docker-network-and-ensure-containers-can-talk-to-each-other
and https://forums.docker.com/t/no-route-to-host-network-request-from-container-to-host-ip-port-published-from-other-container/39063/17

