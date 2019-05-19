#! /bin/sh

mv run_servers.py /data

cd data
./run_servers.py

while sleep 3600; do :; done

