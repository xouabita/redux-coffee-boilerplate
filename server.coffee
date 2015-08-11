express = require 'express'
colors  = require 'colors'
ejs     = require 'ejs'
React   = require 'react'
fs      = require 'fs'

app = express()

{ routes, fetchDataFromRoute, makeHandler } = require './App'
{ createRedux } = require 'redux'

base_html = fs.readFileSync './__dist__/base.html', 'utf-8'
Router    = require 'react-router'

app.use '/api', require './api'
app.use (req, res, next) ->

  router = Router.create
    location: req.url
    routes: routes

  reducers = require './reducers'
  redux    = createRedux reducers

  router.run (Handler, state) ->

    fetchDataFromRoute(state, redux).then ->
      initialState = redux.getState()
      handler      = makeHandler Handler, redux
      html         = React.renderToString handler
      res.send ejs.render base_html,
        react: html
        metas: []
        state: JSON.stringify initialState

app.listen 8000, ->
  console.log "\nYour app is now running on port 8000\n".green.underline
