#!/bin/bash
MIX_ENV=prod PORT=4001 mix deps.get 
MIX_ENV=prod PORT=4001 mix compile
MIX_ENV=prod PORT=4001 mix release

