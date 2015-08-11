# Webpack plugins
HtmlWebpackPlugin              = require 'html-webpack-plugin'
ExtractTextPlugin              = require "extract-text-webpack-plugin"
{ HotModuleReplacementPlugin } = require "webpack"
{ optimize }                   = require "webpack"
{ NoErrorsPlugin }             = require "webpack"

# Stylus plugins
nib     = require "nib"
rupture = require "rupture"

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Options
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~
# hot: yes|no
# devServer: yes|no
# hashed: yes|no
# devtool: yes|no
# separateStyles: yes|no
# separateVendor: yes|no
# optiImgs: yes|no
# minimize: yes|no
# publicPath: {string}
# noErrors: yes|no

module.exports = (options) ->

  options = options or {}

  # ~~~~~~~ Entry ~~~~~~~~~
  # Add "webpack/hot/dev-server" if options.hot
  entry =
    app:
      if options.hot then ["./client.coffee", "webpack/hot/dev-server"]
      else "./client.coffee"

  if options.separateVendor
    entry.vendor = [
      "react"
      "react-router"
      "jquery"
    ]


  # ~~~~~~ Output ~~~~~~~~~
  output =
    path: __dirname + "/__build__/public/"
    publicPath:
      if options.publicPath then options.publicPath
      else
        "/static/"
    filename:
      if options.hashed then "app-[hash].js"
      else "app.js"


  # ~~~~~~~~ Resolve ~~~~~~~~
  resolve =
    moduleDirectories: ['node_modules']
    extensions: ['', '.webpack.js', '.web.js', '.js', '.coffee']


  # ~~~~~~ devtool ~~~~~~~~
  devtool = if options.devtool then "#cheap-module-eval-source-map"


  # ~~~~~~ Loaders ~~~~~~~~
  common_loaders = [
    test: /\.(ttf|eot|svg|woff|otf)$/,
    loader: 'file-loader'
  ,
    test: /\.woff2?$/,
    loader: 'url-loader?limit=10000&minetype=application/font-woff'
  ]


  _imgLoader = [
    test: /\.(jpe?g|png|gif)$/
    loader:
      if options.optiImgs
        "file!image-webpack?optimizationLevel=7&interlaced=false"
      else 'file'
  ]

  _coffeeLoader = [
    test: /\.coffee$/
    loader:
      if options.hot then "react-hot!coffee!cjsx"
      else "coffee!cjsx"
    exclude: "node_modules"
  ]

  _styleLoaders = [
    test: /\.styl$/,
    loader: 'style!css!stylus'
    id: 1
  ,
    test: /\.css$/,
    loader: 'style!css'
    id: 2
  ]

  if options.separateStyles
    for style in _styleLoaders
      style.loader = ExtractTextPlugin.extract "style",
        style.loader.split('style!')[1],
        id: style.id

  loaders = common_loaders.concat(_coffeeLoader)
                          .concat(_styleLoaders)
                          .concat(_imgLoader)


  # ~~~~~~ Stylus ~~~~~~
  stylus =
    use: [
      nib()
      rupture()
    ]


  # ~~~~~~ Plugins ~~~~~~
  plugins = []

  _configHtmlPlugin =
    hash: if options.hashed then yes else no
    hot_reload: if options.hot then yes else no
    template: './views/base.html'
    filename: '../../__dist__/base.html'
    inject: 'body'

  plugins.push new HotModuleReplacementPlugin if options.hot

  if options.separateStyles
    plugins.push(
      new ExtractTextPlugin 2, "vendors-[hash].css"
      new ExtractTextPlugin 1, "styles-[hash].css"
    )

  if options.separateVendor
    _filename = if options.hashed then 'vendor-[hash].js' else 'vendor.js'
    plugins.push new optimize.CommonsChunkPlugin
      name: 'vendor'
      filename: _filename

  plugins.push new HtmlWebpackPlugin _configHtmlPlugin

  plugins.push new optimize.UglifyJsPlugin() if options.minimize

  plugins.push new NoErrorsPlugin() if options.noErrors

  # ~~~~~~ Config returned ~~~~~~~
  entry: entry
  output: output
  resolve: resolve
  devtool: devtool
  stylus: stylus
  module:
    loaders: loaders
  plugins: plugins
