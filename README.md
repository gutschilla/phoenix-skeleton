# Deprecation-Warning

This is pretty old as it refers to a 3-year old version of Phoenix. If I'll do monolithic web apps in Elixir again, I'll post my results here.

# Phoenix-Sekeleton

My skeleton to bootstrap a new Phoenix app.

## Description
This is my application skeleton that integrates useful things (see
[ROADMAP](./ROADMAP.md)) when starting a new project with phoenix. Starting from
100% scratch every time went tediuos so here it goes. Most changes to this
project are backported from live production projects. So yes, albeit a bit
quirky here and there this code runs in production.

## Usage 
After cloning this project, I do run a search/replace on the code and file names
replacing "Skeleton" with "WhateverMyAppIsCalled" and "skeleton" with
"whatever_my_app_is_called". 

## Version
Master branch currently supports Phoenix v1.1.2 

- for full changes list, see [CHANGES](./CHANGES.md)
- for roadmap, see [ROADMAP](./ROADMAP.md)

## What's new in v.0.19.0?

"prod releasing"

- tuned `mix.ex`s and `config/prod.exs` in a way that exrm can create a working release (thanks to *hykw* for reporting on this)

## coming up next

- document how to use NavigationTree.Agent in a practical manner. Backport NavigationTree renderers from other projects here to provide templates for use with Zurb/Foundation side navigation bars (It's easy!)
- move Plug.Authorization.Roles into an external dependency (plug_authorization_roles)
- make it configurable from NavigationTree

# Installation

This assumes a Debian/Ubuntu environment. Max OSX should be similar, except that packages are installed with homebrew instead of apt-get.

0. Install System dependencies (see section _System dependencies_)
1. Install Elixir dependencies with `mix deps.get`
2. Install npm dependencies for ranch with `npm install`
    1. You might want to run `brunch builld` to check if js/css compiling and concatenation works
3. create database with postgre script below
    - run as postgres superuser: `sudo -u postgres psql postgres`
    ```
    CREATE ROLE skeleton_dev_user LOGIN
      ENCRYPTED PASSWORD 'md5465fc2608ab7a4ebe4eaa198e63b85a7'
      NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;
    CREATE DATABASE skeleton_dev
      WITH OWNER = skeleton_dev_user
           ENCODING = 'UTF8'
           TABLESPACE = pg_default
           LC_COLLATE = 'de_DE.UTF-8'
           LC_CTYPE = 'de_DE.UTF-8'
           CONNECTION LIMIT = -1
           TEMPLATE = template0
          ;
    ```
    This will create a database `skeleton_dev` that is accessible by `skeleton_dev_user` using password `skeleton_dev_pass`. You should tune this to your needs, of course.
    _Hint_: You may need to adjust de_DE.UTF-8 to en_US.UTF-8 for US-english Collation using this Gist: (https://gist.github.com/ffmike/877447)
4. run `mix.compile` to see if everything builds fine
5. run `mix ecto.migrate Repo` to create required database tables
6. Start Phoenix endpoint with `mix phoenix.server` or  `iex -S mix phoenix.server` if you wish to have a console

**Now you can visit `127.0.0.1:4000` from your browser.**

## Create development database

This will create a database "skeleton_dev" owned by "skeleton_dev_user" with password "skeleton_dev_pass". Tune this to yout needs.


This only creates the database. To install all required tables (users, userroles, user_userrole_map), run `mix ecto.migrate Repo`. This will also install a simple user with zsername "admin" with password "admin" and userroles ["admin"] that you can log in with to access /ADMIN/*.

# System dependencies

I try to keep up with th latest releases of our dependencies, namely:

- Erlang/Elixir
    - tested on Erlang/OTP 18.2 \[erts-7.2\] and Elixir 1.2.0
    - On Debian/Ubuntu I use Linuxbrew to keep up-to-date, see: [brew.sh/linuxbrew](http://brew.sh/linuxbrew/)
    - On a Mac you probably know [Homebrew](http://brew.sh)
    - `brew update && brew install elixir` Should install both Elixir and Erlang.
    - On poduction servers I prefer [debian packages obtained from Erlang Solutions](https://www.erlang-solutions.com/resources/download.html) 
- PostgreSQL (tests run on 9.4)
    - see config/dev.exs for host/user/port settings
    - `sudo apt-get install postgresql postgresql-contrib postgresql-server-dev-all` works fine on Debian/Ubuntu
- memcached running on 127.0.0.1:11211
    - `apt-get install memcached` works fine on Debina/Ubuntu
    - if you have memcached running on another host/port, adjust settings in `conf/dev.exs conf/prod.exs`  
- nodejs and npm
    - on Debian/Ubuntu "deb.nodesource.com" works great, or just download nodejs from [nodejs.org](https://nodejs.org/en/download/)
    - on a Mac, presumably you'll need to use homebrew
    - tested on node v5.4.0 and npm 3.3.12
    - used for brunch: ran all this with brunch 2.1.3

# Deployment

Hot code relaod is not covered here. See [https://exrm.readme.io/docs/upgradesdowngrades]

## simple (pack, copy, run)

- run `bash etc/compile_release.sh`
- copy `rel/skeleton/releases/<version>/skeleton.tar.gz` to your production machine
- extract, then run `bin/skeleton --start` or `bin/skeleton --console` (if you want and iex shell)

## install as daemon on Linux

This assumes a linux production machine with systemd as init system and a bash
shell. Something like Debian 8/Jessie or Ubuntu 15.04/vivid (tested on both
distributions). Also, this assumes

- nxing 1.6+ being configured in /etc/nginx
- postgre 9.3+
- memcached instance listening on 127.0.0.1:11211

run `apt-get install nginx memcached postgresql-9.4` on Debian/Ubtuntu have a config as above

=======
### install
I am used to put these things into `/var/www-apps/<project-name>`. Scripts and
configs in ./etc are tuned to this. As root/superuser do this:

```
mkdir /var/www-apps
cd /var/www-apps
git clone https://github.com/gutschilla/phoenix-skeleton.git
cd phoenix-skeleton
npm install
mix compile
mix ecto.migrate
bash etc/compile_release.sh
bash etc/install.sh
systemctl nginx reload
```

### upgrade to current master
```
cd /var/www-apps/phoenix-skeleton
git pull
bash etc/compile-release.sh
systemctl restart phoenix_skeleton_backend.service
```

If this doesn't work (most often when you didn't increase your app's version),
run either `mix release --implode` (be sure to set MIX_ENV=prod and PORT=4001)
or simply delete the whole ./rel folder. 

CAUTION: After deleting the ./rel folder it's currently required to run
`rel/skeleton/bin/skeleon console` as privileged user as this will create
neccessary directories which can't be done by an unprivileged user. TODO: Update
compile-release script to create. 

# Glitches

phoenix-skeleton depends on misc_random which compiles with a warning:
`lib/random.ex:11: warning: erlang:now/0: Deprecated BIF"` on Erlang 18. This
can safely be ignored as on Erlang 18 `:erlang.now/0` will not e used in favour of
`:erlang.monotonic_time/0`

At a certain point, I'll require Erlang 18 to get rid of this and always use
`:erlang.monotonic_time/0`.

# Feedback

Is more than welcome. I am still learning this whole Elixir and Erlang/OTP thing
so be rude, be harsh but be helpful.
