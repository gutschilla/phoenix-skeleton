(function(/*! Brunch !*/) {
  'use strict';

  var globals = typeof window !== 'undefined' ? window : global;
  if (typeof globals.require === 'function') return;

  var modules = {};
  var cache = {};

  var has = function(object, name) {
    return ({}).hasOwnProperty.call(object, name);
  };

  var expand = function(root, name) {
    var results = [], parts, part;
    if (/^\.\.?(\/|$)/.test(name)) {
      parts = [root, name].join('/').split('/');
    } else {
      parts = name.split('/');
    }
    for (var i = 0, length = parts.length; i < length; i++) {
      part = parts[i];
      if (part === '..') {
        results.pop();
      } else if (part !== '.' && part !== '') {
        results.push(part);
      }
    }
    return results.join('/');
  };

  var dirname = function(path) {
    return path.split('/').slice(0, -1).join('/');
  };

  var localRequire = function(path) {
    return function(name) {
      var dir = dirname(path);
      var absolute = expand(dir, name);
      return globals.require(absolute, path);
    };
  };

  var initModule = function(name, definition) {
    var module = {id: name, exports: {}};
    cache[name] = module;
    definition(module.exports, localRequire(name), module);
    return module.exports;
  };

  var require = function(name, loaderPath) {
    var path = expand(name, '.');
    if (loaderPath == null) loaderPath = '/';

    if (has(cache, path)) return cache[path].exports;
    if (has(modules, path)) return initModule(path, modules[path]);

    var dirIndex = expand(path, './index');
    if (has(cache, dirIndex)) return cache[dirIndex].exports;
    if (has(modules, dirIndex)) return initModule(dirIndex, modules[dirIndex]);

    throw new Error('Cannot find module "' + name + '" from '+ '"' + loaderPath + '"');
  };

  var define = function(bundle, fn) {
    if (typeof bundle === 'object') {
      for (var key in bundle) {
        if (has(bundle, key)) {
          modules[key] = bundle[key];
        }
      }
    } else {
      modules[bundle] = fn;
    }
  };

  var list = function() {
    var result = [];
    for (var item in modules) {
      if (has(modules, item)) {
        result.push(item);
      }
    }
    return result;
  };

  globals.require = require;
  globals.require.define = define;
  globals.require.register = define;
  globals.require.list = list;
  globals.require.brunch = true;
})();
"use strict";

!(function () {
  "use strict";var e = "undefined" != typeof window ? window : global;if ("function" != typeof e.require) {
    var t = {},
        n = {},
        i = function i(e, t) {
      return ({}).hasOwnProperty.call(e, t);
    },
        r = (function (_r) {
      var _rWrapper = function r(_x, _x2) {
        return _r.apply(this, arguments);
      };

      _rWrapper.toString = function () {
        return _r.toString();
      };

      return _rWrapper;
    })(function (e, t) {
      var n,
          i,
          r = [];n = /^\.\.?(\/|$)/.test(t) ? [e, t].join("/").split("/") : t.split("/");for (var o = 0, s = n.length; s > o; o++) i = n[o], ".." === i ? r.pop() : "." !== i && "" !== i && r.push(i);return r.join("/");
    }),
        o = function o(e) {
      return e.split("/").slice(0, -1).join("/");
    },
        s = function s(t) {
      return function (n) {
        var i = o(t),
            s = r(i, n);return e.require(s, t);
      };
    },
        a = function a(e, t) {
      var i = { id: e, exports: {} };return (n[e] = i, t(i.exports, s(e), i), i.exports);
    },
        c = (function (_c) {
      var _cWrapper = function c(_x, _x2) {
        return _c.apply(this, arguments);
      };

      _cWrapper.toString = function () {
        return _c.toString();
      };

      return _cWrapper;
    })(function (e, o) {
      var s = r(e, ".");if ((null == o && (o = "/"), i(n, s))) return n[s].exports;if (i(t, s)) return a(s, t[s]);var c = r(s, "./index");if (i(n, c)) return n[c].exports;if (i(t, c)) return a(c, t[c]);throw new Error("Cannot find module \"" + e + "\" from \"" + o + "\"");
    }),
        l = function l(e, n) {
      if ("object" == typeof e) for (var r in e) i(e, r) && (t[r] = e[r]);else t[e] = n;
    },
        u = function u() {
      var e = [];for (var n in t) i(t, n) && e.push(n);return e;
    };e.require = c, e.require.define = l, e.require.register = l, e.require.list = u, e.require.brunch = !0;
  }
})(), require.define({ phoenix: function phoenix(e) {
    "use strict";var t = (function (_t) {
      var _tWrapper = function t(_x, _x2, _x3) {
        return _t.apply(this, arguments);
      };

      _tWrapper.toString = function () {
        return _t.toString();
      };

      return _tWrapper;
    })(function (e, t, n) {
      t && Object.defineProperties(e, t), n && Object.defineProperties(e.prototype, n);
    }),
        n = function n(e, t) {
      if (!(e instanceof t)) throw new TypeError("Cannot call a class as a function");
    },
        i = { connecting: 0, open: 1, closing: 2, closed: 3 },
        r = e.Channel = (function () {
      function e(t, i, r, o) {
        n(this, e), this.topic = t, this.message = i, this.callback = r, this.socket = o, this.bindings = null, this.reset();
      }return (t(e, null, { reset: { value: function value() {
            this.bindings = [];
          }, writable: !0, configurable: !0 }, on: { value: function value(e, t) {
            this.bindings.push({ event: e, callback: t });
          }, writable: !0, configurable: !0 }, isMember: { value: function value(e) {
            return this.topic === e;
          }, writable: !0, configurable: !0 }, off: { value: function value(e) {
            this.bindings = this.bindings.filter(function (t) {
              return t.event !== e;
            });
          }, writable: !0, configurable: !0 }, trigger: { value: function value(e, t) {
            this.bindings.filter(function (t) {
              return t.event === e;
            }).map(function (e) {
              return e.callback(t);
            });
          }, writable: !0, configurable: !0 }, send: { value: function value(e, t) {
            this.socket.send({ topic: this.topic, event: e, payload: t });
          }, writable: !0, configurable: !0 }, leave: { value: function value() {
            var e = void 0 === arguments[0] ? {} : arguments[0];this.socket.leave(this.topic, e), this.reset();
          }, writable: !0, configurable: !0 } }), e);
    })(),
        o = (e.Socket = (function () {
      function e(t) {
        var r = void 0 === arguments[1] ? {} : arguments[1];n(this, e), this.states = i, this.stateChangeCallbacks = { open: [], close: [], error: [], message: [] }, this.flushEveryMs = 50, this.reconnectTimer = null, this.reconnectAfterMs = 5000, this.heartbeatIntervalMs = 30000, this.channels = [], this.sendBuffer = [], this.transport = r.transport || WebSocket || o, this.heartbeatIntervalMs = r.heartbeatIntervalMs || this.heartbeatIntervalMs, this.logger = r.logger || function () {}, this.endPoint = this.expandEndpoint(t), this.resetBufferTimer(), this.reconnect();
      }return (t(e, null, { protocol: { value: function value() {
            return location.protocol.match(/^https/) ? "wss" : "ws";
          }, writable: !0, configurable: !0 }, expandEndpoint: { value: function value(e) {
            return "/" !== e.charAt(0) ? e : "/" === e.charAt(1) ? "" + this.protocol() + ":" + e : "" + this.protocol() + "://" + location.host + e;
          }, writable: !0, configurable: !0 }, close: { value: function value(e, t, n) {
            this.conn && (this.conn.onclose = function () {}, t ? this.conn.close(t, n || "") : this.conn.close(), this.conn = null), e && e();
          }, writable: !0, configurable: !0 }, reconnect: { value: function value() {
            var e = this;this.close(function () {
              e.conn = new e.transport(e.endPoint), e.conn.onopen = function () {
                return e.onConnOpen();
              }, e.conn.onerror = function (t) {
                return e.onConnError(t);
              }, e.conn.onmessage = function (t) {
                return e.onConnMessage(t);
              }, e.conn.onclose = function (t) {
                return e.onConnClose(t);
              };
            });
          }, writable: !0, configurable: !0 }, resetBufferTimer: { value: function value() {
            var e = this;clearTimeout(this.sendBufferTimer), this.sendBufferTimer = setTimeout(function () {
              return e.flushSendBuffer();
            }, this.flushEveryMs);
          }, writable: !0, configurable: !0 }, log: { value: function value(e) {
            this.logger(e);
          }, writable: !0, configurable: !0 }, onOpen: { value: function value(e) {
            this.stateChangeCallbacks.open.push(e);
          }, writable: !0, configurable: !0 }, onClose: { value: function value(e) {
            this.stateChangeCallbacks.close.push(e);
          }, writable: !0, configurable: !0 }, onError: { value: function value(e) {
            this.stateChangeCallbacks.error.push(e);
          }, writable: !0, configurable: !0 }, onMessage: { value: function value(e) {
            this.stateChangeCallbacks.message.push(e);
          }, writable: !0, configurable: !0 }, onConnOpen: { value: function value() {
            var e = this;clearInterval(this.reconnectTimer), this.transport.skipHeartbeat || (this.heartbeatTimer = setInterval(function () {
              return e.sendHeartbeat();
            }, this.heartbeatIntervalMs)), this.rejoinAll(), this.stateChangeCallbacks.open.forEach(function (e) {
              return e();
            });
          }, writable: !0, configurable: !0 }, onConnClose: { value: function value(e) {
            var t = this;this.log("WS close:"), this.log(e), clearInterval(this.reconnectTimer), clearInterval(this.heartbeatTimer), this.reconnectTimer = setInterval(function () {
              return t.reconnect();
            }, this.reconnectAfterMs), this.stateChangeCallbacks.close.forEach(function (t) {
              return t(e);
            });
          }, writable: !0, configurable: !0 }, onConnError: { value: function value(e) {
            this.log("WS error:"), this.log(e), this.stateChangeCallbacks.error.forEach(function (t) {
              return t(e);
            });
          }, writable: !0, configurable: !0 }, connectionState: { value: function value() {
            switch (this.conn && this.conn.readyState) {case this.states.connecting:
                return "connecting";case this.states.open:
                return "open";case this.states.closing:
                return "closing";default:
                return "closed";}
          }, writable: !0, configurable: !0 }, isConnected: { value: function value() {
            return "open" === this.connectionState();
          }, writable: !0, configurable: !0 }, rejoinAll: { value: function value() {
            var e = this;this.channels.forEach(function (t) {
              return e.rejoin(t);
            });
          }, writable: !0, configurable: !0 }, rejoin: { value: function value(e) {
            e.reset(), this.send({ topic: e.topic, event: "join", payload: e.message }), e.callback(e);
          }, writable: !0, configurable: !0 }, join: { value: function value(e, t, n) {
            var i = new r(e, t, n, this);this.channels.push(i), this.isConnected() && this.rejoin(i);
          }, writable: !0, configurable: !0 }, leave: { value: function value(e) {
            var t = void 0 === arguments[1] ? {} : arguments[1];this.send({ topic: e, event: "leave", payload: t }), this.channels = this.channels.filter(function (t) {
              return !t.isMember(e);
            });
          }, writable: !0, configurable: !0 }, send: { value: function value(e) {
            var t = this,
                n = function n() {
              return t.conn.send(JSON.stringify(e));
            };this.isConnected() ? n() : this.sendBuffer.push(n);
          }, writable: !0, configurable: !0 }, sendHeartbeat: { value: function value() {
            this.send({ topic: "phoenix", event: "heartbeat", payload: {} });
          }, writable: !0, configurable: !0 }, flushSendBuffer: { value: function value() {
            this.isConnected() && this.sendBuffer.length > 0 && (this.sendBuffer.forEach(function (e) {
              return e();
            }), this.sendBuffer = []), this.resetBufferTimer();
          }, writable: !0, configurable: !0 }, onConnMessage: { value: function value(e) {
            this.log("message received:"), this.log(e);var t = JSON.parse(e.data),
                n = t.topic,
                i = t.event,
                r = t.payload;this.channels.filter(function (e) {
              return e.isMember(n);
            }).forEach(function (e) {
              return e.trigger(i, r);
            }), this.stateChangeCallbacks.message.forEach(function (e) {
              e(n, i, r);
            });
          }, writable: !0, configurable: !0 } }), e);
    })(), e.LongPoller = (function () {
      function e(t) {
        n(this, e), this.retryInMs = 5000, this.endPoint = null, this.token = null, this.sig = null, this.skipHeartbeat = !0, this.onopen = function () {}, this.onerror = function () {}, this.onmessage = function () {}, this.onclose = function () {}, this.states = i, this.upgradeEndpoint = this.normalizeEndpoint(t), this.pollEndpoint = this.upgradeEndpoint + (/\/$/.test(t) ? "poll" : "/poll"), this.readyState = this.states.connecting, this.poll();
      }return (t(e, null, { normalizeEndpoint: { value: function value(e) {
            return e.replace("ws://", "http://").replace("wss://", "https://");
          }, writable: !0, configurable: !0 }, endpointURL: { value: function value() {
            return this.pollEndpoint + ("?token=" + encodeURIComponent(this.token) + "&sig=" + encodeURIComponent(this.sig));
          }, writable: !0, configurable: !0 }, closeAndRetry: { value: function value() {
            this.close(), this.readyState = this.states.connecting;
          }, writable: !0, configurable: !0 }, ontimeout: { value: function value() {
            this.onerror("timeout"), this.closeAndRetry();
          }, writable: !0, configurable: !0 }, poll: { value: function value() {
            var e = this;(this.readyState === this.states.open || this.readyState === this.states.connecting) && s.request("GET", this.endpointURL(), "application/json", null, this.ontimeout.bind(this), function (t, n) {
              if (n && "" !== n) {
                var i = JSON.parse(n),
                    r = i.token,
                    o = i.sig,
                    s = i.messages;e.token = r, e.sig = o;
              }switch (t) {case 200:
                  s.forEach(function (t) {
                    return e.onmessage({ data: JSON.stringify(t) });
                  }), e.poll();break;case 204:
                  e.poll();break;case 410:
                  e.readyState = e.states.open, e.onopen(), e.poll();break;case 0:case 500:
                  e.onerror(), e.closeAndRetry();break;default:
                  throw "unhandled poll status " + t;}
            });
          }, writable: !0, configurable: !0 }, send: { value: function value(e) {
            var t = this;s.request("POST", this.endpointURL(), "application/json", e, this.onerror.bind(this, "timeout"), function (e) {
              200 !== e && t.onerror(e);
            });
          }, writable: !0, configurable: !0 }, close: { value: function value() {
            this.readyState = this.states.closed, this.onclose();
          }, writable: !0, configurable: !0 } }), e);
    })()),
        s = e.Ajax = { states: { complete: 4 }, request: function request(e, t, n, i, r, o) {
        var s = this,
            a = XMLHttpRequest ? new XMLHttpRequest() : new ActiveXObject("Microsoft.XMLHTTP");a.open(e, t, !0), a.setRequestHeader("Content-type", n), a.onerror = function () {
          o && o(500, null);
        }, a.onreadystatechange = function () {
          a.readyState === s.states.complete && o && o(a.status, a.responseText);
        }, r && (a.ontimeout = r), a.send(i);
      } };Object.defineProperty(e, "__esModule", { value: !0 });
  } }), "object" != typeof window || window.Phoenix || (window.Phoenix = require("phoenix"));require.register("web/static/js/app", function(exports, require, module) {
"use strict";

var Socket = require("phoenix").Socket;

// let socket = new Socket("/ws")
// socket.join("topic:subtopic", {}, chan => {
// })

var App = {};

module.exports = App;});

;
//# sourceMappingURL=app.js.map