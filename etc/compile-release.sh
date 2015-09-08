#!/bin/bash
MIX_ENV=prod PORT=4001 mix deps.get 
MIX_ENV=prod PORT=4001 mix compile
brunch build --production
MIX_ENV=prod PORT=4001 mix phoenix.digest 
MIX_ENV=prod PORT=4001 mix release
