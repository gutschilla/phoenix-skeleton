# CHANGES

## What's new in v0.16.0?

- Upgrade project to support Phoenix v0.16.1
- Temporarily drop memcached-saved sessions, using default cookie-store until I get it to work with exrm
- Finally include a _working_ brunch config (no need for links from bower_components to web/static any more)
- move roadmap to ROADMAP.md

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

