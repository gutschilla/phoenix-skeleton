'use strict';
var exec = require('child_process').exec;
var fs = require('fs');
var logger = require('loggy');
var mkdirp = require('mkdirp');
var sysPath = require('path');
var rimraf = require('rimraf');
var ncp = require('ncp');
var utils = require('./utils');

// Shortcut for backwards-compat fs.exists.
var fsexists = fs.exists || sysPath.exists;

// Executes `npm install` and `bower install` in rootPath.
//
// rootPath - String. Path to directory in which command will be executed.
// callback - Function. Takes stderr and stdout of executed process.
//
// Returns nothing.
var install = function(rootPath, callback) {
  var prevDir = process.cwd();
  logger.log('Installing packages...');
  process.chdir(rootPath);
  fsexists('bower.json', function(exists) {
    var installCmd = 'npm install';
    if (exists) installCmd += ' & bower install';
    exec(installCmd, function(error, stdout, stderr) {
      var log;
      process.chdir(prevDir);
      if (stdout) console.log(stdout.toString());
      if (error != null) {
        log = stderr.toString();
        var bowerNotFound = /bower\: command not found/.test(log);
        var msg = bowerNotFound ? 'You need to install Bower and then install skeleton dependencies: `npm install -g bower && bower install`. Error text: ' + log : log;
        return callback(new Error(msg));
      }
      callback(null, stdout);
    });
  });
};

var ignored = function(path) {
  return !(/^\.(git|hg)$/.test(sysPath.basename(path)));
};

// Copy skeleton from file system.
//
// skeletonPath   - String, file system path from which files will be taken.
// rootPath     - String, directory to which skeleton files will be copied.
// callback     - Function.
//
// Returns nothing.
var copy = function(skeletonPath, rootPath, callback) {
  var copyDirectory = function() {
    ncp(skeletonPath, rootPath, {filter: ignored}, function(error) {
      if (error != null) return callback(new Error(error));
      logger.log('Created skeleton directory layout');
      install(rootPath, callback);
    });
  };

  // Chmod with 755.
  mkdirp(rootPath, 0x1ed, function(error) {
    if (error != null) return callback(new Error(error));
    fsexists(skeletonPath, function(exists) {
      if (!exists) {
        var error = "skeleton '" + skeletonPath + "' doesn't exist";
        return callback(new Error(error));
      }
      logger.log('Copying local skeleton to "' + rootPath + '"...');

      copyDirectory();
    });
  });
};

// Clones skeleton from URI.
//
// address     - String, URI. https:, github: or git: may be used.
// rootPath    - String, directory to which skeleton files will be copied.
// callback    - Function.
//
// Returns nothing.
var clone = function(address, rootPath, callback) {
  var gitHubRe = /(gh|github)\:(?:\/\/)?/;
  var url = gitHubRe.test(address) ?
    ("git://github.com/" + address.replace(gitHubRe, '') + ".git") : address;
  logger.log('Cloning git repo "' + url + '" to "' + rootPath + '"...');
  exec("git clone " + url + " " + rootPath, function(error, stdout, stderr) {
    if (error != null) {
      return callback(new Error("Git clone error: " + stderr.toString()));
    }
    logger.log('Created skeleton directory layout');
    rimraf(sysPath.join(rootPath, '.git'), function(error) {
      if (error != null) return callback(new Error(error));
      install(rootPath, callback);
    });
  });
};

// Main function that clones or copies the skeleton.
//
// skeleton    - String, file system path or URI of skeleton.
// rootPath    - String, directory to which skeleton files will be copied.
// callback    - Function.
//
// Returns nothing.
var initSkeleton = function(skeleton, rootPath, callback) {
  var banner, error;
  var cwd = process.cwd();
  if (rootPath == null) rootPath = cwd;
  if (typeof rootPath === 'function') {
    callback = rootPath;
    rootPath = cwd;
  }
  if (skeleton === '.' && rootPath === cwd) skeleton = null;
  if (callback == null) {
    callback = function(error) {
      if (error != null) return logger.error(error.toString());
    };
  }
  if (skeleton == null) {
    banner = fs.readFileSync(sysPath.join(__dirname, 'banner.txt'), 'utf8');
    error = banner.replace(/\{\{command\}\}/g, initSkeleton.commandName);
    return callback(new Error(error));
  }

  switch (skeleton) {
    case 'exim':    skeleton = 'gh:hellyeahllc/brunch-with-exim'; break;
    case 'chaplin': skeleton = 'gh:paulmillr/brunch-with-chaplin'; break;
    case 'angular': skeleton = 'gh:scotch/angular-brunch-seed'; break;
    case 'ember':   skeleton = 'gh:ksnyde/brunch-with-ember-sideloaded'; break;
  }

  var uriRe = /(?:https?|git(hub)?|gh)(?::\/\/|@)?/;
  fsexists(sysPath.join(rootPath, 'package.json'), function(exists) {
    if (exists) {
      return callback(new Error("Directory '" + rootPath + "' is already an npm project"));
    }
    var isGitUri = skeleton && uriRe.test(skeleton);
    var get = isGitUri ? clone : copy;
    get(skeleton, rootPath, callback);
  });
};

initSkeleton.commandName = 'init-skeleton';

module.exports = initSkeleton;
