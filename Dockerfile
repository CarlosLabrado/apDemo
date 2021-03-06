FROM resin/raspberry-pi-python:3.4

ENV INITSYSTEM on


RUN apt-get update && apt-get install -y \
		dnsmasq \
&& rm -rf /var/lib/apt/lists/*

# Install required Python packages
RUN pip install --upgrade pip

# Install required Python packages
RUN pip install -U \
 -Iv Flask==0.12.4 \
 Flask-WTF \
 python-networkmanager \
 zerorpc

COPY dnsmasq.conf /etc/dnsmasq.conf

# Defines our working directory in container
WORKDIR /usr/src/app

# This will copy all files in our root to the working  directory in the container
COPY . ./

# server.js will run when container starts up on the device
CMD ["bash", "front.sh"]