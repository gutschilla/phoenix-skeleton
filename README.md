# Phoenix-Sekeleton

This is an old version. The current efforts in directory "next" are made to implement 
- standard EEX templates (erlydtl works, but relaoding is not supported and error messages are a pain)(35%)
- using the phoenix 0.7.2 API(done)
- package all dependencies Navigation(done), Helpers, PDF) in own umbrella project
- let memcached session be initializes as application (done)

## Feature Roadmap
- [x] Basic routing
- [x] Authentication
    - [x] hard-wired
    - [x] from Database (Ecto/Postgres)
    - [ ] Salted, hashed passwords
- [ ] Authorization
    - [x] Userroles Ecto defintion
    - [x] User object that contains matchable roles
- [x] Memcached Session store
- [x] Django Templates (erlyDTL)
- [x] Ecto models
- [x] call/process external programs via porcelain (mainly for PDF generation)
    - [ ] stream input/output instead of writing to and reading from temp files
- [x] pluggable Navigation tree
    - [x] navigation tree that depends on user roles
- [ ] CouchDB connector
- [ ] Hello2.Admin.RESTCrud controller
    - [ ] validate/save
    - [ ] uploads
    - [ ] Image resizing
- [ ] TinySite CMS
- [ ] Create mix task to boostrap components instead of copy/paste+search/replace
- [ ] BUGFIX: Skeleton2.Router.url shall work again

To start your new Phoenix application you have to:

1. Install dependencies with `mix deps.get`
2. Install js libraries with `bower install`
3. Start Phoenix router with `mix phoenix.start`

Now you can visit `localhost:4000` from your browser.


## Notes

* If you choose to change the application's structure, you could manually start the router from your code like this `Skeleton.Router.start`
