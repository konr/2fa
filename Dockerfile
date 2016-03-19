FROM ubuntu:latest

RUN apt-get update -y && \
    apt-get install oathtool -y && \
    apt-get install jq -y

COPY gen-token /usr/local/bin/gen-token
COPY tokens.json /etc/tokens.json

ENTRYPOINT ["/usr/local/bin/gen-token"]

