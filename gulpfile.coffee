gulp    = require "gulp"
webpack = require "webpack"
nodemon = require "nodemon"
fs      = require "fs"

WebpackDevServer = require "webpack-dev-server"

dev_server_url = "http://localhost:4243/"

# ~~~~~~~~~~~~~~~~~~~
# Miscellaneous tasks
# ~~~~~~~~~~~~~~~~~~~

gulp.task 'clean-prod', ['copy'], (done) ->
  gulp.src('__build__/**', {read: false}).pipe(clean({force: true}))

gulp.task 'copy', (done) ->
  gulp.src('./assets/imgs/icon/**').pipe(gulp.dest('./__build__/public/icon/'))

gulp.task "s3-prod", ['build-server-prod'], (done) ->
  aws = JSON.parse(fs.readFileSync('./config/aws.json'))
  gulp.src('./__build__/public/**')
      .pipe(s3(aws))


# ~~~~~~~~~~~~~
# Webpack tasks
# ~~~~~~~~~~~~~

doServerConfig = require './webpack.server.coffee'
doClientConfig = require './webpack.client.coffee'

devConfig = doClientConfig
  hot: yes
  publicPath: dev_server_url
  devtool: yes
  devServer: yes
  hashed: no
  separateStyles: no
  noErrors: yes

tunnelConfig = doClientConfig
  hot: no
  publicPath: "/static/"
  devServer: no
  hashed: yes
  separateStyles: yes
  separateVendor: yes
  minimize: yes
  optiImgs: yes

serverDev = doServerConfig
  publicPath: dev_server_url
  devtool: yes

serverTunnel = doServerConfig
  optiImgs: yes

configs =
  dev: devConfig
  tunnel: tunnelConfig

serverConfigs =
  dev: serverDev
  tunnel: serverTunnel


onBuild = (done) ->
  (err, stats) ->
    if err then console.log 'Error', err
    else console.log stats.toString()
    if done then done()

# Generate gulp tasks from configs
_config_keys = Object.keys configs
_config_keys.forEach (config) ->

  gulp.task "build-frontend-#{config}", (done) ->
    webpack(configs[config]).run onBuild(done)

  gulp.task "web-server-#{config}", ->
    compiler = webpack configs[config]
    server   =  new WebpackDevServer compiler,
      contentBase: './__build__/public/'
      hot: yes
    server.listen 4243, "localhost", ->

  gulp.task "build-server-#{config}", ["build-frontend-#{config}"], (done) ->
    webpack(serverConfigs[config]).run onBuild(done)

  gulp.task "watch-server-#{config}", ["build-frontend-#{config}"], ->
    webpack(serverConfigs[config]).watch 100, (err, stats) ->
      onBuild() err, stats
      nodemon.restart()

  gulp.task "nodemon-#{config}", ["watch-server-#{config}", "web-server-#{config}"], ->
    nodemon
      execMap: js: 'node'
      script: __dirname + "/__build__/server"
      ignore: ['*']
      watch: ['foo/']
      ext: 'noooooooooooooooo'
    .on 'restart', -> "Backend restarted".rainbow

gulp.task "dev", ["nodemon-dev"]
gulp.task "tunnel", ["build-server-tunnel", "build-frontend-tunnel"]

gulp.task "default", ["dev"]


# Documentation
docco = require 'docco'
gulp.task 'docco', (done) ->
  docco.document
    args: ['App.coffee', 'views/Todo.coffee', 'client.coffee', 'server.coffee']
    layout: 'linear'
  , done
