FROM rocker/geospatial:latest
MAINTAINER "OverTista" giambattista.mameli@overit.it

ARG PASSWORD=password

RUN mkdir -p /usr/src/r_geospatial

COPY fprmcda.tar.gz /usr/src/r_geospatial
COPY rpyserve.py /usr/src/r_geospatial

WORKDIR /mnt/volumes/statics/static/script_r/

RUN install2.r --error \
    rasterVis \
    FuzzyAHP \
    phylin \
    tmap

RUN install2.r --error /usr/src/r_geospatial/fprmcda.tar.gz -r NULL

RUN apt-get update && apt-get install -y python

EXPOSE 9090

CMD /init & python rpyserve.py --hostname 0.0.0.0 --port 9090 > /var/log/rpyserve.log
