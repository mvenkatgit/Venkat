Hypervisor 
=====
vm ware,oracle virtual box,citrix xen
########################################

problem with traditional approch
   - Installations & configuration
   - Time consuming
   -  need to perfome install.config accross all the servers like DEV,QA,PROD, we may endup with inconsitency with the configurations

Compatability:
 



kernal is we can it as middleware it will help to convert into the binary lanaguage

container's are light weight due to each container will not have OS

Advantages:

#############

Flexible
Lightweight
portable  --> build once deploy run any where
Loosely coupled --> self sufficent
scalable

####################

Dockerfile --> which contains instruction to build an image
Dockerimage --> it's a package which contains app code it
s depencies

DockerContainer --> Runtime instance/process of image
Docker Registery --> to store the artifactory
#############################

Docker is a containerzation tool
Docker container orchestration tools 

  -  Docker swarm (Kubernates)



Docker networks
Docker volumes
Docker compose
Docker swarm
  Cluster setup
  Deploying services
  Deploying stack 
  secrets
############################################################################



DockerFile
############


Docker is a file to it will have instruction to build the an image quicky
-- Docker daemon runs the instructions in the Dockerfile are proceed
-- The Dockerfile i the source code of the Docker image
##############################################


Docker Image
############

Docker image is a lightweight stand-alone executable package that includes eveything needed to run a piece of software including the code a runtime libraries envirornment variables and config files
The image contains to intereact with kernal
 

-- it works well with microservice


Improve sppeed and freqency of releases,reliability
Makes app lifecycle efficient,consistent and repeatable-config once,run many times
Eliminate environment incosistencies between development,test,production
improve production
#############################################################################

Architecture of Docker 

-----------------------



  Docker client 
  Docker Daemon
  Docker Registry


Docker Client
------------
  This is a command line interface to send the commands to execute


Docker Daemon
-------------

Docker Daemon is the process of process the commands sent by the user that might be pulling an image or installing an os image from the registry or running a container etc

Docker Registry
###############

This is a central repositroy maintained by Docker and it's called Docker Hub, This Registry containes various Public image that can be used we can also crate our own image
#############################################

Registry --> Collection of one or more repo
Repo --> Collections of one or mor eversions same tyep image
####################################################

Docker is ocquared by miarents
#######################

Docker has two types 

Docker Community editin -- Free
Docker enterprice edition -- Commercial
 UCP --> Universal control pane (GUI to manage the docker)
 DTR --> Docker Trusted Registry

   
#################################################


OS --> Cross platform 

##############################


Redhat/CentOs/Amazonos

yum

Ubuntu/Debian
APT
#############################################################################################




installation



apt-get update
apt-get install docker.io
sudo usermod -aG docker $USER (a means add G means group)
 once we add we should be able to get 
and we can run as a normal user 

but we should exit and run
#######################################



Dockerfile


FROM: tomcat:7-jdk8-corretto
COPY: /maven-web-application*.war /usr/local/tomcat/webapps/maven-web-application.war




docker build -t <Registery>/<Repository>:1 . t means tag

docker build -t ashoknagari/maven-web-application:1 .


docker build -t 1938.383.383/maven-web-application:1 .

docker build -t nexus.com/maven-web-application:1 .

here . represt the current directory



--

 we should build an war file first by using

apt-get install maven it should contain the java as well

and we should build an image by using Dockerfile

FROM: tomcat:7-jdk8-corretto
COPY: /maven-web-application.*war /usr/local/tomcat/webapps/maven-web-application.war

and we shuld build and image like below

docker build -t ashoknagari/maven-web-application:1 .


we should push the image to download it from another server 

docker login -u ashoknagari

docker push ashoknagari/maven-web-application:1



Docker images or docker image ls
Docker login 
docker pull 
docker push


############################

docker login -u ashoknagari  --> to login to the docker hub 
docker login -u admin -p password <private repo url here>


docker image inspect imageid  --> information about the image
docker rmi imageid --> to delete the image
docker rmi images $(docker)


docker build -t ashoknagari/maven-web-application:2 -f Dockerfile ~/maven-web-applicationfolder ( we have Dockerfile in home and required code to copy in maven-web-applicationfolder)



image is nothing but a layers

home directory of that is /var/lib/docker/




to see the layers from image we can use elow command


docker history imagenamehere

docker history ashoknagari/maven-web-app:1



docker build --no-cache -t ashoknagari/maven-web-app:2 .

docker rmi -q to display the id's

docker rmi $(docker images -q)

docker rmi -f 



when we remove by uing -f it will just untag it will not remove the image


what is dangling image
an image which is not having repo details or which is not tagged

command is 

docker images -f dangling=true


we can tag the repo which is not having by using below command



docker tag imageidhere ashoksachin/maven-web-application:1



command to delete the container

docker rmi containernamehere


#####################################

docker system prune
docker image prune
docker container prune
docker volume prune
 

 docker logs my-nexus | grep "Nexus Repository Manager"




################################################


Registary is collection of reposities
Repository is collections of diffrent version of same image

########################################################################


how to push to the private repository ecr (elastic container registary)

we should authenticate with the aws to our docker below are teh steps



we should go to the ecr create the 

we should give the name over there

and we should attach the role (admin acccess not suggested but we can attach)

and we shoudl attach that role to ec2 instance by going to security option and we can attach that role

once we attach 

we can authenticate by using below command

aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin 533267397791.dkr.ecr.us-east-2.amazonaws.com


and we can build an image using below command
'
 docker build -t 533267397791.dkr.ecr.us-east-2.amazonaws.com/maven-web-app:1 .

and now we can push by using below command 
--> docker push 533267397791.dkr.ecr.us-east-2.amazonaws.com/maven-web-app:1

we can pull the same image using below command
 --> docker pull 533267397791.dkr.ecr.us-east-2.amazonaws.com/maven-web-app:1

#############################################################################

creating container 

docker run -d --name containernamehere -p 8080:8080 533267397791.dkr.ecr.us-east-2.amazonaws.com/maven-web-app:1 .

this we should run in where we have the source code

docker save imagename -o Filename.tar

docker load -i Filename.tar
########################################################################################################################


container concept
######################



docker create -p hostport:containerport --name containername imagename:1

docker run -p -d 8080:8080 --name containername imagename:1


d means detached mode


<hostport>:<containerport>

container port can be same but host port shoul'nt be the same




docker create that creates the container but not starting

docker run will create and run the container


docker ps -a to list the all the containers
docker container ls -a    -- to list the containers same command




docker start containername

#############################


what is portbinding or port forwarding

if we want to access container out side of the network

#####################################


docker run -d --name mavenapps -p hostport:containerport imagenamehere:1
sudo ss -tulnp --> to check what are the ports are opened (ubuntu)
sudo netstat -tulnp -- same command to check the open ports (Amazon linux or Redhat)



For running containers we can't attach the volumes and we can't change the ports to change the ports we should only remove the container and recreate


######################



docker restart <containerid or name>

docker stop  <containerid or name>
docker start  <containerid or name>
doker kill  <containerid or name>

docker rename <containerid or name> <newname>


sudo cd ls -lrt /var/lib/docker/containers -- this is the place where docker maintaine the containers

######################################



docker stop and kill

docker stop --  we are just stopping the container

docker kill -- we are forcefully stopping the process
docker pause --> it's just going to the sleeping mode 
docker unpause containername
##################################################

docker troubleshoot

we can check the what process is running on the inside of container using below command

docker top containernameorid

################################################

Resource consumption



docker run --memory="500Mi" --cpus="0.5"



we can monitor the container cpu utilization using below command


docker stats containernameorid


docker logs containernameorid -t 


command to go to the inside of the container

docker exec -it containernameorid bash  (it means interactive mode)



#######################################################

what is docker commit 


docker commit containername  imagenamewecangive



can we create multipleprocess in one container?

technically it's possible but not suggestable

#######################################



docker attach containernameorid


it will display the all the logs to the terminal if we process ctrl+c it will stop the process


########################################################

Docker cp

#################


Docker copy we can use to copy file from container to hostmachine hostmachine to container

same thing in COPY in dockerifle


docker cp javawebapp:/usr/local/tomcat/logs/host-manager.log container.log --> we are copying from container to system
docker cp container.log java:webapp:/usr/local/tomcat/logs/ --> we are copying from system to container

##################################################################################################################################


Dockerfile


Dockerfile will have instructions to create an image docker will process the commands from top to buttom


we will use Docker DSL (Docker Specific language) keywords in dockerfile

######################################


FROM

MAINTAINER

COPY

ADD

RUN

CMD

ENTTRYPOINT

ENV

LABEL

ARG

USER

WORKDIR

EXPOSE

VOLUME

COPY . .

########################################################################


FROM ubuntu:latest
#####
MAINTAINER: Author of this file
##########
COPY target/maven-web-application.war /usr/local/tomcat/webapps/maven-web-application.war 
####
	
# COPY . . (Current working direcy and current working directrory of the image)


ADD
####
 It's also used to copy the files
- it's also used to download from the remote http https servers 
-- which is ending with tar files it will download and extract the files from remote
-- it will take only *.tar it won't support .tar.gz or zip filess




RUN

it execute the commands  on top of base images


RUN mkdir -p /home/ubuntu/folder1/folder2
RUN yum install java 

RUN keyword will works while creating an image
  -- using RUN we can executes commands on top of base image. RUN instruction will be executed while creating an image
 it will help to the install package and creating an images
 we can we multiple RUN keywords



CMD
####

CMD is used to execute while creating a container

it will help to start the process as well we can have only one CMD

Docker will process only one CMD it can be recent or last


ENTRYPOINT
#############

ENTRYPOINT instruction alo will be executed while creating a container, we can set an entry point (command) for our container while we want to execute



ubuntu@ip-172-31-40-124:~$ cat Dockerfile
FROM ubuntu:latest
RUN mkdir /rundirectory
RUN echo "creating a directory as a RUN commadn here"
RUN apt-get update -y
#CMD ["echo", "Welcome FROM CMD Running as a CMD command"]
ENTRYPOINT ["echo", "Welcome FROM ENtrypoint"]
ubuntu@ip-172-31-40-124:~$







WORKDIR
ENV
LABEL
ARG
USER
EXPOSE
VOLUME



WORKDIR --> Using this keyword we can set the working directory for an image or container

WORKDIR <DirPath>

 WORKDIR /usr/local/tomcat


ENV --> we can set environment variables using ENV. These variables can be accessable in image (while creating image) 

ENV <KEY> <VALUE> 



LABEL 

   LABELS are key value pairs which can be add to the image like an information



ARG
  -- like a variable which we can define and refer in docker file at run time while creating an image also we can pass arguments arg can be accesable only while creating an image. we can refer/acces in container


docker build -t imageone --build-arg branch=dev .


FROM centos
RUN echo "RUN one"
RUN mkdir /app
RUN echo echo "RUN two"
RUN yum install unzip -y
CMD ["echo", "Welcome FROM CMD"]
CMD date
ENV TEST TestingENV
ARG branch=develop
LABEL branchname $branch


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 USER --> we can set an user for an image or container. The instruction we will be executed as whater user we have sset using USER
###############################################################



Multi state dockerfile


FROM git as repo
WORKDIR /app
RUN git clone git@github.com:AMLSDEVOPS/maven-web-application.git


FROM maven as build
WORKDIR /app
COPY -from=repo /app/java-web-app-docker /app
RUN mvn clean install

FROM tomcat:8.0
COPY --from=build /app/targer/java-web-app.war /usr/local/tomcat/webapps/java-web-app.war

wha
mostly we won't use this multi stage dockerfile requirement


docker rm $(docker ps -q)
###################################################################




what is shell form what is executable form

RUN,CMD,ENTRYPOINT intructionss can be defined as a shell form or executable form

RUN CMD ARGS
CMD CMD ARGS
ENTRYPOINT CMD ARGS

RUN mkdir -p /usr/test
CMD java -jar app.jar

CMD sh test.sh

ENTRYPOINT java -jar app.jar

########################
executable from it will exuecuted as 
internally
/bin/shell -c command


RUN ["CMD", "ARG1", "ARG2"]
CMD ["java","-jar","app.jar"]
CMD ["sh", "test.sh"]
ENTRYPOINT ["java", "-jar", "app.jar"] 

/bin/executable args
                       
#####################################################################################

-d means detached mode



what is imporant points to be considered while deploying applications as container?

1. Developer should not hard code the configurations environment specific details like DB Username,password.etc in the code

2. we have externilize the configuration for diffrent environment           



########################################################


docker network create springappnetwork
docker run -d -p 8080:8080 --name springapp -e MONGO_DB_HOSTNAME=mongo -e MONGO_DB_USERNAME=devdb -e MONGO_DB_PASSWORD=devdb@123 --network springappnetwork ashoknagari/mongoimage:1


docker run -d --name mongo -e MONGO_INITDB_ROOT_USERNAME=devdb -e MONGO_INITDB_ROOT_PASSWORD=devdb@123 --network springappnetwork mongo


we are just connecting to a application and DB servers

#############################################################

we will have two types of applications

stateless application
statefull application


binding mount means  creating volume with folder like a attaching

 docker run -d --name mongo -e MONGO_INITDB_ROOT_USERNAME=devdb -e MONGO_INITDB_ROOT_PASSWORD=devdb@123 -v /home/ubuntu/mongo:/data/db --network springappnetwork mongo

######################################################################


outside of docker volumes
persistant volumes

#######################
persistant volumes like creating the volumes and attach to it

docker volume create volumenamehere

docker run -d --name mongo -e MONGO_INITDB_ROOT_USERNAME=devdb -e MONGO_INITDB_ROOT_PASSWORD=devdb@123 -v mangodvol:/data/db --network springappnetwork mongo


#######################



docker plugin install rexray/ebs EBS_ACCESSKEY=AKIAXYKJWXSPR3Z6FANW EBS_SECRETKEY=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

docker plugin install rexray/ebs \
  EBS_ACCESSKEY=AKIAXYKJWXSP7K7X4DVA \
  EBS_SECRETKEY=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


we should create the volume from this driver like below

docker volume create -d rexray/ebs mongodb-->this is the name we are providing for the driver volume


docker run -d --name mongo -e MONGO_INITDB_ROOT_USERNAME=devdb -e MONGO_INITDB_ROOT_PASSWORD=devdb@123 -v mongodbedsvol:/data/db -network springappnetwork mongo

volume is important for stateful appliations


image --> package
container --> process
network --> communication each container should talk to another container
volume --> storage
#########################################################################################


Docker compose

################


what is docker compose

#########################

why do we need docker compose 

##############################



docker compose is a tool using which we can deplloy multiple container applications 
##############################


version:
services:
volumes:
networks:
####################################

Docker Compose
###############


Docker swarm cluster --> group of Docker servers called a cluster, there will be a master and workers
Master --> it will schedule the tasks to the nodes

#########################################





Docker swarm is used to create when container is going down


Docker cluster management and orchestration  feature embeded in Dockerengine

-- cluster od docker engines or nodes
one or more manager,and rest workers


Swarm Features
###############


Cluster Management
Decentralize desing
Declarative service model
Scalling
Desired state reconciliation
Multi-host network
Service discovery
load balancing
Secure by default
Rolling Updates



############################

Additional Network Checks

TCP 2377

TCP UDP port 7946
UDP port 4789
####################


we should enable the these ports on aws security 
and we should init the in one of the master node where we init that will become as a master

docker swarm init

it will give the two types of tokens 
swam token 
master token

once we get the token we should take and make another node to join to the cluste


docker swam join-token worker
docker swarm join-token manager


###########################

what is docker swarm manager quarm?

(n-1)/2
2-1/2 = 0.5 raft algaridham

minimum 3 master machines
odd number of machines

they have 13 docker machines

3 master machines
10 worker machine


DEV 

QA

PROD
  


to use docer swarm  we should create a service 

service is collection of one or more containers of same type (image)

two types of services in docker swarm

replica mode
global mode

these are the two types of services in dockdr swarm

docker service create --name servicename -p hostport:containerport --replica 4 imagename:1


default mode is replica mode by default it will create 1 


docker service create --name javawebappservice -p 8080:8080 imagenamehere


docker service ps javawebapp --> to see where our application is running on which node

by default it will run on master machine


docker service scale servicename=noofreplicas

ex:
docker service scale javawebappservice=3 



service act as a load balancer as well


doker service create --name servicename --replica -p hostport:containerport imagename' 


docker doess'nt support auto scalling
docker service scale javawebapps=4
 


command to create from global mode

###############################


docker service create --name mavenwebapp --made global -p 9090:8080 ashoknagari/maven-web-app


diffrence between replica mode and global mode 


in replica mode we can scale up and down

in global mode we can't scale up and down


in global mode

each and every active node will have a copy of a container for global services. we can't scale up and scale down, when ever we add new node container will  be automatically scheduled in that new node for global services
#######################################################


microservice will be deployed in replica mode

whenever we add a node into a cluster that should run a container like monitoring tools 

########################################################################


container placement
###########################


labels $ constraints
Drain the node to not to take the containers

##########################

labels $ constraints
doker service create --name mavenwebapp --replica 3--constrait "node.role==worker" --mode global -p 7070:8080 ashoknagari/maven-web-application:1
 
above command is to not to schedule in the master


docker node update <idhere> --avaialability drain 
 it won't take the containers but it's avaialbe


when we drain the node so that container's will rescheduel to another container



docker node update idhere --avaialability active

to schedule on specific node

 by using labels we can schedule

docker node ls

docker node update --label-add "type=server" id


docker service create --name javawebservice --replica 3 --constraint "node.labels.type==appserver" -p 8080:8080 ashoknagari/maven-web-app
	
  

we can promot worker as a leader with below command


docker node premote nodenameid
how to make a as a worker back (docker node demote nodenameorid) 


########################################


we can create a one single file and we can keep this commands into it

#################################################



to deploy docker swarm file


docker stack --> collection of services for some application.
docker stack ls
docker stack deploy --compose-file docker-compose.yml springapp
                  



version: '3.1'

services:
  springboot:
    image: ashoknagari/spring-boot-mongo:latest
    restart: always # This will be ignored if we deploy in docker swarm
    container_name: springboot
    environment:
    - MONGO_DB_HOSTNAME=mongo
    - MONGO_DB_USERNAME=devdb
    - MONGO_DB_PASSWORD=devdb1234
    ports:
      - 8080:8080
    working_dir: /opt/app
    depends_on:
    - mongo
    deploy:  # This will be considered only in docker swarm.
      replicas: 2
      update_config:
        parallelism: 1
        delay: 20s
      restart_policy:
        condition: on-failure
        delay: 10s
        max_attempts: 5
    networks:
    - springappoverlay
  mongo:
    image: mongo
    container_name: springboot-mongo
    environment:
    - MONGO_INITDB_ROOT_USERNAME=devdb
    - MONGO_INITDB_ROOT_PASSWORD=devdb1234
    volumes:
      - mongodb:/data/db
    restart: always
    networks:
    - springappoverlay
    
volumes:
  mongodb:
    external: true
    
networks:
  springappoverlay:
    external: true    



when we use and this file there won't be any down time 

when we push a new version of the image that will be running by taking new version 
###############################################################################

how many clusters have?

3 clusters


how many docker node u have in production?

3 - managers

10 - workers  - 700+ containers and 12 applications
 
#######################

what is the configuration of your nodes?

128 GB capacity 
64 Core process

########################################

how many services you have in docker swarm

12 stack


how many containers you have?
###########################################


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
