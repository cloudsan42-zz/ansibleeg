# Ubuntu 16.04 LTS
# Oracle Java 1.8 64 bit

# extend the most recent long term support Ubuntu version
FROM ubuntu:16.04

# this is a non-interactive automated build - avoid some warning messages
ENV DEBIAN_FRONTEND noninteractive

# UTF-8
RUN locale-gen en_US.UTF-8
ENV LANG       en_US.UTF-8
ENV LC_ALL     en_US.UTF-8

# update dpkg repositories
RUN apt-get update && \
  apt-get dist-upgrade -y

# Remove any existing JDKs
RUN apt-get --purge remove openjdk*

# Install Oracle's JDK
RUN echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections
RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" > /etc/apt/sources.list.d/webupd8team-java-trusty.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886
RUN apt-get update && \
  apt-get install -y --no-install-recommends oracle-java8-installer && \
  apt-get clean all

# set java environment
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

# remove download archive files
RUN apt-get clean

# copy runnable java file to docker
ADD scripts/Script.java /Script.java

# copy runnable sh file to docker
ADD scripts/testfile.txt /testfile.txt

# copy runnable sh file to docker
ADD scripts/script.sh /script.sh

# set execute permission for script file
RUN chmod +x /script.sh

# build java script file
RUN javac Script.java

CMD java Script && \
	  bash script.sh
