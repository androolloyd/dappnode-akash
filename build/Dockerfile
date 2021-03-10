FROM golang:1.15.0 AS go-builder

WORKDIR /go/src/github.com/ovrclk/akash

ENV DEBIAN_FRONTEND=noninteractive

RUN git clone --recursive ${UPSTREAM_VERSION} https://www.github.com/ovrclk/akash.git .

RUN make deps-install && make install
# Add supervisor configuration files

ENV NODE_HOME=/.akash
WORKDIR $NODE_HOME

EXPOSE 26656 26657 26658
EXPOSE 1317

COPY ./scripts/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod u+x /usr/local/bin/entrypoint.sh
ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]

# STOPSIGNAL SIGINT
