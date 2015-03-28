# Phoenix-Sekeleton

## Feature Roadmap
- [x] Basic routing
- [x] Authentication
    - [x] from Database (Ecto/Postgres)
    - [ ] Salted, hashed passwords
    - [ ] Merge Login from 0.7  
- [ ] Authorization
    - [x] Userroles Ecto defintion 
    - [x] User object that contains matchable roles
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
    - [ ] uploads
    - [ ] Image resizing
- [ ] TinySite CMS
- [ ] Create mix task to boostrap components instead of copy/paste+search/replace

# System dependencies

- Erlang/Elixir, of course ;-)
- PostgreSQL (tests run on 9.4, but 9.x shoulb be OK)
    - see config/dev.exs for host/user/port settings
- memcached
    - assumed to run on 127.0.0.1:11211
- npm package manager
    - tested with 1.4.28
- bower package manager
    - tested with 1.3.12

# Installation

1. Install Elixir dependencies with `mix deps.get`
2. Install npm dependencies for ranch with `npm install`
    - on Debuan/Ubuntu "deb.nodesource.com" works great
3. Install bower dependecies with `bower install`
2. Start Phoenix endpoint with `mix phoenix.server`


Now you can visit `localhost:4000` from your browser.
