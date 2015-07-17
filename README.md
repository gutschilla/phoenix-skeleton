# Phoenix-Sekeleton

Master branch currently supports Phoenix v0.14.0

# What's new in 0.14?

- Support fort phoenix 0.14 
- integrate brunch to handle assets
- improved documentation: added Postgre commands for fast setup of development database
- deployment guide: systemd files, running skeleton app as unprivileged user
- return to old "Skeleton" namespace for everything.
- navigation tree is a macro for shorter config, now

# Coming Soon! Not yet documented

- deployment scripts (systemd service files and nginx conf)

## Feature Roadmap
- [x] Basic routing
- [x] Authentication
    - [x] from Database (Ecto/Postgres)
    - [x] salted/hashed passwords (hmac_sha256)
    - [x] basic Login page
- [x] Authorization
    - [x] Userroles Ecto defintion 
    - [x] Skeleton.Helper.roles_of( user ) returns string_
    - [ ] Means to check for roles in controllers/actions
- [x] Memcached Session store
    - this is done via the plug gutschilla/plug-session-memcached
    - [ ] make Memcached host/port configurable
- [x] Django Templates (erlyDTL) => removed, see 0.7. now using eex (running with the crowd)
- [x] Ecto models
- [x] call/process external programs via porcelain (mainly for PDF generation)
    - [ ] stream input/output instead of writing to and reading from temp files
- [x] pluggable Navigation tree
    - [x] navigation tree that depends on user roles
        - this is done via the gutschilla/phoenix_skeleton_deps_umbrella dependecy which includes then NavigationTree module
- [ ] CouchDB connector
- [ ] Hello2.Admin.RESTCrud controller
    - [ ] validate/save
    - [ ] uploads ()
    - [ ] Image resizing (will be done via dragonfly-server [using convert/ImageMagick])
- [ ] TinySite CMS
- [ ] Create mix task to boostrap components instead of copy/paste+search/replace

# Installation

1. Install Elixir dependencies with `mix deps.get`
2. Install npm dependencies for ranch with `npm install`
    - on Debuan/Ubuntu "deb.nodesource.com" works great
3. Install bower dependecies with `bower install`
4. Check system dependencies, run postgre dev script below
5. Start Phoenix endpoint with `mix phoenix.server`

Now you can visit `localhost:4000` from your browser.

# System dependencies

- Erlang/Elixir, of course ;-)
- PostgreSQL (tests run on 9.4)
    - see config/dev.exs for host/user/port settings (CAUTION: dev host is set to 192.168.0.240, this will fail on your machine, set to locahost!)
- memcached
    - assumed to run on 127.0.0.1:11211
- npm package manager
    - tested with 1.4.28
- bower package manager
    - tested with 1.4.1

## Create development database

This will create a database "skeleton_dev" owned by "skeleton_dev_user" with password "skeleton_dev_pass". Tune this to yout needs.

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
       CONNECTION LIMIT = -1;
```
# Deployment

Hot code relaod is not covered here. Be sure to meet system dependencies.

## simple (pack, copy, run)

- run `bash etc/compile_release.sh`
- copy `rel/skeleton/releases/<version>/skeleton.tar.gz` to your production machine
- extract, then run `bin/skeleton --start` or `bin/skeleton --console` (if you want and iex shell)

## my favourite (clone, pack, run-as-service)
### install
I am used to put these things into `/var/www-apps/<project-name>`. Scripts and configs in ./etc are tuned to this.
```
cd /var/www-apps
git clone https://github.com/gutschilla/phoenix-skeleton.git
cd phoenix-skeleton
bash etc/compile_release.sh
npm install
bower install
systemctl enable /var/www-apps/phoenix-skeleton/etc/phoenix_skeleton_backend.service
systemctl start phoenix_skeleton_backend.service
cd /etc/nginx/sites-available
ln -s /var/www-apps/phoenix-skeleton/etc/skeleton.nginx skeleton
cd /etc/nginx/sites-enabled
ln -s /etc/nginx/sites-available/skeleton
systemctl nginx reload
```

### upgrade to current master
```
cd /var/www-apps/phoenix-skeleton
git pull
bash etc/compile-release.sh
systemctl restart phoenix_skeleton_backend.service
```

# Feedback

Is more than welcome. I am still learing this whole Elixir and Erlang/OTP thing so be rude, be harsh but be helpful.
