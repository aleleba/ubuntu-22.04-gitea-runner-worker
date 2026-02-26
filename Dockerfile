# base
FROM ubuntu:24.04

# Update Package
RUN apt-get update
# Install apt-utils
RUN apt-get install -y --no-install-recommends apt-utils
# Install Sudo
RUN apt-get -y install sudo
# Install Curl
RUN apt-get -y install curl
# Install VIM
RUN apt-get -y install vim

# update the base packages and install Xvfb
RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y libgtk2.0-0 libgtk-3-0 libgbm-dev libnotify-dev libnss3 libxss1 libasound2t64 libxtst6 xauth xvfb

# Installing Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && \
    apt-get install -y nodejs
# Finished installing Node.js

#Installing Docker
# Let's start with some basic stuff.
RUN sudo apt-get update -qq && sudo apt-get install -qqy \
    apt-transport-https \
    ca-certificates \
    curl \
    lxc \
    iptables   
# Install Docker from Docker Inc. repositories.
RUN curl -sSL https://get.docker.com/ | sh
# Define additional metadata for our image.
VOLUME /var/lib/docker

#Install Docker Compose
RUN sudo curl -L https://github.com/docker/compose/releases/download/v5.1.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
RUN sudo chmod +x /usr/local/bin/docker-compose
RUN docker-compose --version
#Finishing Installing Docker Compose

# Install kubectl
#Install kubectl
RUN sudo apt-get update && sudo apt-get install -y gnupg curl apt-transport-https ca-certificates
RUN curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
RUN echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
RUN sudo apt-get update
RUN sudo apt-get install -y kubectl
#Finishing Instaling kubectl
#Finishing Instaling kubectl

# Script to make Docker In Docker Available
RUN sudo update-alternatives --set iptables /usr/sbin/iptables-legacy
RUN sudo update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

CMD [ "node" ]