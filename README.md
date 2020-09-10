# linkorgs-app

This project is part of a bachelor thesis at the Vienna University of Economics and Business (https://www.wu.ac.at/). It has been developed to fill a gap in the current
ecosystem and serves as a development repository for the name-giving webservice. You can find the corresponding thesis here (blabla.org) and our service at (data.wu.ac.at/xy).

# Installation

We use docker-compose to make the project easily launchable. Find more information on how to install docker-compose here: https://docs.docker.com/compose/install/

If docker is installed, run:

```
git clone https://github.com/N-Krenn/linkorgs-app/
cd linkorgs-app
```

## Configuration and Launch

We provide some configuration options in the env file in the root directory and they should be pretty self-explanatory.
Please update further settings in the regarding packages, future configuration methods will be launched later.

Finally, run

```
docker-compose build php-app
docker-compose up -d
```

To start the docker containers. Everything should be live now, reachable under localhost:80/app.php. You can access the PGADMIN tool (https://www.pgadmin.org/download/pgadmin-4-container/) via localhost:5050, using the predefined configurationed credentials. We recommend using the PGSQL Admin Credentials to connect to the database.

To make use of the service, the only input required is the CKAN API link to the respective dataset. This can be achieved either manually (localhost/app.php?api_link=YOURAPILINK.COM/) or via our CKAN Extension, which essentially does only provide an embedded HTML iframe with the associated datasets API Link. (https://github.com/N-Krenn/ckanext-linkorgs)
