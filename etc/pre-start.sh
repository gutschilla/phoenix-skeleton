#!/bin/bash

USER=phoenix-skeleton
ROOT=/var/www-apps/phoenix-skeleton
APP=skeleton

# create and chown tmp and log directories
test -d              $ROOT/rel/$APP/log \
	|| mkdir     $ROOT/rel/$APP/log
chown -R $USER:$USER $ROOT/rel/$APP/log

test -d              $ROOT/rel/$APP/tmp \
            || mkdir $ROOT/rel/$APP/tmp
chown -R $USER:$USER $ROOT/rel/$APP/tmp

# return proper code
exit 0

