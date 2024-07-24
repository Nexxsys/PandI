#!/bin/bash

sudo docker ps --format '{{.ID}} {{.Names}}' | while read -r id name; do 
echo -n "$name - "
    docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' "$id"
done
