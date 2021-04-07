# Test-Task to deploy LAMP with various methods (Dockerfile, Packer, Docker-Compose)
## Dockerfile
### Apache&PHP Image
_For building Apache+PHP image you must run this command in PowerShell:_
```sh
docker build --pull --rm -f ".\test-task\apachephp\Dockerfile" -t docker-apachephp:latest "test-task\apachephp"
```
_or bash\sh:_
```sh
docker build --pull --rm -f "test-task/apachephp/Dockerfile" -t docker-apachephp:latest "test-task/apachephp"
```
_If build was succesful, you can run container from that image, by using this command in PowerShell or bash:_
```sh
docker run -d -p 80:80 docker-apachephp:latest
```
> In some situations, your local port 80 already binded by other process. By -p parameter you can specify other local port to bind (except 0-1024 ports), as example `-p 8080:80`

_After that, in browser come to `http://localhost:[PORT]/index.php` , and you will see default PHP Info Page._


### MySQL Image

_Before building, you can specify default `MYSQL_USER` and `MYSQL_PASSWORD` in mysql\Dockerfile file. These credentials will be using for connecting to MySQL in future._

_For building MySQL image you must run this command in PowerShell:_
```cmd
docker build --pull --rm -f ".\test-task\mysql\Dockerfile" -t docker-mysql:latest "test-task\mysql"
```
_or bash\sh:_
```sh
docker-lamp# docker build --pull --rm -f "test-task/mysql/Dockerfile" -t docker-mysql:latest "test-task/mysql"
```
_If build was succesful, you can run container from that image, by using this command in PowerShell or bash:_
```sh
docker run -d -p 3306:3306 docker-mysql:latest
```
_After that you can connect to MySQL on `localhost:3306`, or from other container, by using IP of container, where MySQL is installed._
____________
## Packer

_This method will building separated images of Apache+PHP and MySQL at one time._
_For building by packer, on your OS must be installed Packer, version not less than 1.7.1._ _How to install packer on your OS you can find on [this page](https://learn.hashicorp.com/tutorials/packer/getting-started-install)._ _Before building, you can specify default `mysq_user` and `mysql_password` for MySQL Connection in build-LAMP.json file, in `variables` block._
_For building images, you must execute these comands in PowerShell or bash:_
```sh
cd test-task
packer build build-LAMP.json
```
_If build was succesful, you can run containers from images builded early, by using these commands in PowerShell or bash:_
```sh
docker run -d -p 3306:3306 packer-mysql:version
docker run -d -p 80:80 packer-apachephp:version
```
>Note: `version` variable by default set to `0.5.1`, you can specify that in build-LAMP.json file, in `variables` block.

_After that you can connect to MySQL on `localhost:3306`, or from other container, by using IP of container, where MySQL is installed. And in browser come to `http://localhost:[PORT]/index.php` - you will see default PHP Info Page._
____________
## Docker-Compose

_This method will build separated images of Apache+PHP and MySQL at one time, by usind docker-compose command. For building by this method, on your OS must be installed `docker-compose`_

_One of sub-methods, is more simply than second. He using a `build` parameter, which use dockerfile, where declarated main instructions for building image._ _You can specify default `MYSQL_USER` and `MYSQL_PASSWORD` in mysql/Dockerfile file_
_For use that sub-method, run this command in PowerShell or bash:_
```sh
docker-compose -f test-task/docker-compose-dockerfiles.yml build
```
_If build was succesful, you can run containers from images builded early, by using these commands in PowerShell or bash:_
```sh
docker run -d -p 3306:3306 docker-compose-mysql:latest
docker run -d -p 80:80 docker-compose-apachephp:latest
```

THIS BLOCK NOT FINISHED