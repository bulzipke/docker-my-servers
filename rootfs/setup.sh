#! /bin/sh

mv run_servers.py /data

cd data
./run_servers.py

/usr/sbin/crond -f
