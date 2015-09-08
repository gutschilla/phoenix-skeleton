# Phoenix-Sekeleton

Master branch currently supports Phoenix v1.0.2

- for full changes list, see [CHANGES](./CHANGES.md)
- for roadmap, see [ROADMAP](./ROADMAP.md)

## What's new in v0.18.1?

- Upgrade the whole thing to use Phoenix 1.0.2
- Throw away bower in favour of plain npm for package management.
- Split vendor CSS (bootstrap, currently) and JS (none, currently) into
  different files for better caching as vendor code usually doesn't change that
  often
- remove phoenix-generated userrole controller. To revert this, run `mix
  phoenix.gen.html Userrole userroles`
- documentation for deployment scripts (systemd service files and nginx conf)

## coming up next

- move Plug.Authorization.Roles into an external dependency, make it configurable from NavigationTree
- re-integrate Plug.Session.memcached as I found out why it didn't work with erxm releases

# Installation

1. Install Elixir dependencies with `mix deps.get`
2. Install npm dependencies for ranch with `npm install`
    - on Debian/Ubuntu "deb.nodesource.com" works great
    - on a Mac, presumably you'll need to use homebrew
3. Install bower dependecies with `bower install`
4. Check system dependencies, run postgre dev script below
5. Start Phoenix endpoint with `iex -S mix phoenix.server`

Now you can visit `127.0.0.1:4000` from your browser.

# System dependencies

- Erlang/Elixir
    - exrm release manager requires us to use Elixir 1.0.5
    - tested on Erlang/OTP 18 \[erts-7.0\]
- PostgreSQL (tests run on 9.4)
    - see config/dev.exs for host/user/port settings (CAUTION: dev host is set to 192.168.0.240, this will fail on your machine, set to locahost!)
- nodejs and npm
    - tested on node v0.12.7 and npm 2.11.3
    - used for brunch: ran all this with brunch 1.8.5

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
       CONNECTION LIMIT = -1
       TEMPLATE = template0
      ;
```
_Hint_: You may need to adjust de_DE.UTF-8 to your needs and use this Gist:
(https://gist.github.com/ffmike/877447)

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

# Feedback

Is more than welcome. I am still learning this whole Elixir and Erlang/OTP thing so be rude, be harsh but be helpful.
