module.exports = config:
  files:
    javascripts: joinTo: 'js/app.js'
    stylesheets: joinTo: 'css/app.css'
  paths:
    watched: ["web/static", "test/static"]
    public: "priv/static"
  plugins:
    babel:
      ignore: [
        /^(web\/static\/vendor)/
        /^(bower_components)/
      ]
