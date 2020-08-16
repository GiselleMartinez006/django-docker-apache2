# Docker configuration for django project deployed on Apache2

This repository shows the docker configuration in order to deploy a django project on apache2.

## Motivation

Deploying a django project on apache2 presents the following problems:

* www-data user for apache2 processes cannot access super user files.
* pip and pip virtual environment isntall packages in different locations with permissions for super user. pip install packages for specific users
* chwon recursive command in docker takes long time

## Possible solution

* The proposed solution is using miniconda packages manager.
* Creating a custom docker image with miniconda3 pre installed, with one new user and sudo installed. Docker image jomvargasm/python3.8-miniconda3
* Building conda environment from the new user using sudo.
* A secrets.json file must be created inside dockerdjango folder, next to django manage.py file. This file hiddes the secret information. The structure of this file must be the following:

```
{
    "SECRET_KEY": "secret",
    "DB_PASSWORD": "password",
    "DB_HOST": "localhost",
    "DB_NAME": "database",
    "DB_USER": "user"
}
```

## Comments

* This is just an example project. The django project has DEBUG set to True, just in order to show the example Django welcome page. This has to be changed! There is one possible line in order to set DEBUG.

## Future

* It is needed to try setting a SSL certificate for apache2 inside docker.

