FROM ubuntu:16.10

RUN apt-get update
RUN apt-get install -y wget duplicity python-requests python-requests-oauthlib
RUN wget https://github.com/breunigs/duplicity-amazondrive/raw/direct/amazondrivebackend.py && mv amazondrivebackend.py /usr/lib/python2.7/dist-packages/duplicity/backends/
