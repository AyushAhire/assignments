FROM ubuntu:20.04

RUN apt-get update && apt-get install -y cowsay fortune netcat

ENV SRVPORT=4499
ENV RSPFILE=response

COPY wisecow.sh /usr/src/app/wisecow.sh

WORKDIR /usr/src/app

EXPOSE $SRVPORT

CMD ["/bin/bash", "wisecow.sh"]
