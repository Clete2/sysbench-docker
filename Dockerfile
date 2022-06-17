FROM ubuntu:20.04

RUN apt update; apt install -y sysbench

COPY sysbench.sh /

ENTRYPOINT ["/bin/bash", "/sysbench.sh"]