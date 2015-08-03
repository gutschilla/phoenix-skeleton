# CHANGES

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

