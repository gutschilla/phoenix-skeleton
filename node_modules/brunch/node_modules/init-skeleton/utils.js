'use strict';
var fs = require('fs');
var mkdirp = require('mkdirp');
var ncp = require('ncp').ncp;
var sysPath = require('path');

// RegExp that would filter invalid files (dotfiles, emacs caches etc).
exports.ignored = function(path) {
  return /(^[.#]|(?:__|~)$)/.test(sysPath.basename(path));
};

// Files that should be always ignored (git / mercurial metadata etc).
exports.ignoredAlways = function(path) {
  return /^\.(git|hg)$/.test(sysPath.basename(path));
};

// Recursively copy files from one directory to another.
// Ignores dotfiles and stuff in process.
//
// source      - String.
// destination - String.
// options     - Object. {filter: Boolean, filterer: Function}
// callback    - Function.
//
// Returns nothing.
exports.copyIfExists = function(source, destination, options, callback) {
  if (options == null) options = {};
  if (options.filter == null) options.filter = true;
  if (options.filterer == null) {
    options.filterer = filter ?
      function(path) {return !exports.ignored(path);} :
      function(path) {return !exports.ignoredAlways(path);};
  }

  var ncpOptions = {
    filter: options.filterer,
    stopOnError: true
  };

  exports.exists(source, function(exists) {
    if (!exists) return callback();
    ncp(source, destination, ncpOptions, callback);
  });
};
