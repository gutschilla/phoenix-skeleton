# CHANGES

## What's new in v.0.19.0?

"prod releasing"

- tuned `mix.ex`s and `config/prod.exs` in a way that exrm can create a working release (thanks to *hykw* for reporting on this)

## What's new in v.0.19.0?

"Upgrades upgrades upgrades!"

- Tune everything to run on/with
    - Elixir 1.2.0
    - Erlang 18.2
    - Phoenix 1.1.2
    - node 5.4
- Use my (gutschilla) packages from hex.pm rather than rely on github
- I hope the _Installation_ section in README is more readable, now

## What's new in v.0.18.3?

"Memcached-works-again"

- include EchoTeam/mcd dependency (TODO: switch to a hex module)
- BUGFIX: start plug_memcached_session's app to startup memcached connection (TODO: make memcached host/port configurable)
- enable memcached as Session.Storage module

## What's new in v0.18.2?

"Upgrade dependencies and see if it still works":

- phoenix 1.0.3
- phoenix_html 2.2
- phoenix_live_reload 1.0.1
- exrm 0.19.9
- Upgrade misc_random to use `:erlang.monotonic_time/0` instead of `:erlang.now/0`
- Test to run on Erlang 18.1, Elixir 1.1.1, Node 4.2.1

## What's new in v0.18.1?

- Upgrade the whole thing to use Phoenix 1.0.2
- Throw away bower in favour of plain npm for package management.
- Split vendor CSS (bootstrap, currently) and JS (none, currently) into
  different files for better caching as vendor code usually doesn't change that
  often
- remove phoenix-generated userrole controller. To revert this, run `mix
  phoenix.gen.html Userrole userroles`
- documentation for deployment scripts (systemd service files and nginx conf)

## What's new in v0.17.0?

- BUGFIX: mentioning navigation_tree in mix.exs' application section will make
  the NavigationTree.Agent be included in a release, thus being _finally_ ready
  for a production cycle!

## What's new in v0.16.0?

- Upgrade project to support Phoenix v0.16.1
- Temporarily drop memcached-saved sessions, using default cookie-store until I get it to work with exrm
- Finally include a _working_ brunch config (no need for links from bower_components to web/static any more)
- move roadmap to ROADMAP.md
- BUG: live css reloader currently not working (not even in clean phoenix install, waiting for upstream fix)

## v0.15.5

 - require navigation_tree 0.3.2 to have NavigationTree.Agent and many bugfixes from there
 - split Plug.Authorization.Roles into different modules to prepare for externalization

## v0.15.4

 - Rewrite Plug.Authorization.Roles to consume different configs
 - Add protocol Plug.Authorization.Roles.Config to allow various configurations on how 
   Plug.Authorization.Roles shall determine which roles are requiresd and how roles are 
   extracted from the current connection. 
   
   TODO: externalize this as dependency, document it, make fancy blogpost.

## What's new in v0.15.3?

- track changes in `CHANGES.md`.
- basic roles authorization in Admin controller

## What's new in 0.15?

- support for phoenix 0.15

## What's new in 0.14?

- Support fort phoenix 0.14 
- integrate brunch to handle assets
- improved documentation: added Postgre commands for fast setup of development database
- deployment guide: systemd files, running skeleton app as unprivileged user
- return to old "Skeleton" namespace for everything.
- navigation tree is a macro for shorter config, now

