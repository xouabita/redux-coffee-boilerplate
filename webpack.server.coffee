{ BannerPlugin } = require 'webpack'


# ~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Options
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~
# publicPath: {string}
# devtool: yes|no
# optiImgs: yes|no

module.exports = (options) ->

  options = options or {}

  # ~~~~~ Output ~~~~~~~
  _publicPath =
    if options.publicPath then options.publicPath
    else "/static/"
  output =
    path: "__build__"
    filename: "server.js"
    libraryTarget: "commonjs2"
    publicPath: _publicPath


  # ~~~~~ Devtool ~~~~~~~
  devtool = if options.devtool then "sourcemap"


  # ~~~~~ Loaders ~~~~~~~~
  commonLoaders = [
      test: /\.coffee$/,
      loader: 'coffee!cjsx',
      exclude: "node_modules"
    ,
      test: /\.svg/
      loader: 'file'
  ]

  _imgLoader = [
    test: /\.(jpe?g|png|gif)$/
    loader:
      if options.optiImgs
        "file!image-webpack?optimizationLevel=7&interlaced=false"
      else 'file'
  ]

  loaders = commonLoaders.concat(_imgLoader)


  # ~~~~~ Plugins ~~~~~~~
  plugins = []
  if options.devtool
    plugins.push new BannerPlugin 'require("source-map-support").install();',
                     raw: true, entryOnly: false


  # ~~~~~~ Config returned ~~~~~~~
  entry: './server.coffee'
  target: 'node'
  context: __dirname
  output: output
  resolve:
    extensions: ['', '.webpack.js', '.web.js', '.js', '.coffee']
  externals: /^[a-z][a-z\.\-0-9]*$/
  devtool: devtool
  module:
    loaders: loaders
  plugins: plugins
