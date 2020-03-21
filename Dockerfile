FROM ubuntu:latest
MAINTAINER "Marcel Gietzmann-Sanders" "marcelsanders96@gmail.com"

# base packages and editor
RUN apt-get -y update && \
	apt-get -y upgrade && \
	apt-get install -y build-essential && \
	apt-get install -y libpq-dev && \
	apt-get install -y vim

# install java, git and wget
RUN apt-get install -y openjdk-8-jre-headless && \
	apt-get install -y git && \
	apt-get install -y wget

# download the build tools
RUN mkdir /server && \
	wget "https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar" -O /server/BuildTools.jar 

# build minecraft
WORKDIR /server
RUN java -jar BuildTools.jar

# install dos2unix
RUN apt-get install -y dos2unix

# plugins
RUN mkdir /server/plugins
COPY plugins/EssentialsX-2.17.2.0.jar /server/plugins/EssentialsX-2.17.2.0.jar
COPY plugins/GroupManager.jar /server/plugins/GroupManager.jar

# copy over the eula.txt
COPY config/eula.txt /server/eula.txt
RUN dos2unix /server/eula.txt

# add ops.json
COPY /config/ops.json /server/ops.json
RUN dos2unix /server/ops.json

# add globalgroups.yml
RUN mkdir /server/plugins/GroupManager
COPY /config/globalgroups.yml /server/plugins/GroupManager/globalgroups.yml
RUN dos2unix /server/plugins/GroupManager/globalgroups.yml
