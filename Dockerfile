FROM ubuntu:latest
MAINTAINER "Marcel Gietzmann-Sanders" "marcelsanders96@gmail.com"

RUN apt-get -y update && \
	apt-get -y upgrade && \
	apt-get install -y build-essential && \
	apt-get install -y libpq-dev

# install java
RUN apt-get install -y openjdk-8-jdk-headless

# install wget
RUN apt-get install -y wget

RUN mkdir /server
RUN wget https://launcher.mojang.com/v1/objects/bb2b6b1aefcd70dfd1892149ac3a215f6c636b07/server.jar -P /server

# install dos2unix
RUN apt-get install -y dos2unix
COPY eula.txt /server/eula.txt
RUN dos2unix /server/eula.txt

WORKDIR /server
CMD java -Xmx1024M -Xms512M -jar server.jar nogui