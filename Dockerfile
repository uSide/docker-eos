FROM ubuntu:18.04

ENV EOS_VERSION=2.0.1
ENV EOS_MINOR_VERSION=1
ENV EOS_CHECKSUM=03b775d2265fa1e620d1a6f2caa93b1de371e21c44277bd0c9ee06752a59beba

WORKDIR /root/
COPY ./genesis.json ./genesis.json
RUN apt-get update && apt-get install -y wget && apt-get clean
RUN wget https://github.com/EOSIO/eos/releases/download/v${EOS_VERSION}/eosio_${EOS_VERSION}-${EOS_MINOR_VERSION}-ubuntu-18.04_amd64.deb \
    && echo "${EOS_CHECKSUM} eosio_${EOS_VERSION}-${EOS_MINOR_VERSION}-ubuntu-18.04_amd64.deb" | sha256sum -c \
    && apt-get install -y ./eosio_${EOS_VERSION}-${EOS_MINOR_VERSION}-ubuntu-18.04_amd64.deb \
    && rm *.deb

ENTRYPOINT ["nodeos"]