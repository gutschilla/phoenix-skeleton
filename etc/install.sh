#!/bin/bash

PROJECT=phoenix-skeleton
DIR=/var/www-apps/$PROJECT
USER=$PROJECT

# create user
useradd $USER
mkdir $DIR/home
chown $USER:$USER $DIR/home
usermod --home $DIR/home

# enable service
systemctl enable $DIR/etc/$PROJECT"_backend".service
echo use \"systemctl start $PROJECT"_backend".service\" to startup $PROJECT service
