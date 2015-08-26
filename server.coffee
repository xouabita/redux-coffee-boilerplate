# ## Entry for server-side
express = require 'express'
colors  = require 'colors'
ejs     = require 'ejs'
React   = require 'react'
fs      = require 'fs'

app = express()

{ routes, fetchDataFromRoute, makeHandler, createStore } = require './App'

base_html = fs.readFileSync './__dist__/base.html', 'utf-8'
Router    = require 'react-router'

app.use '/api', require './api'
app.use (req, res, next) ->

  router = Router.create
    location: req.url
    routes: routes

  store = createStore()

  router.run (Handler, state) ->

    # Resolve all the promises....
    fetchDataFromRoute(state, store).then ->
      # ...then render the route.
      initialState = store.getState()
      handler      = makeHandler Handler, store
      html         = React.renderToString handler
      res.send ejs.render base_html,
        react: html
        metas: []
        state: JSON.stringify initialState

    # Like that, all the data is loaded before the handlers of the route
    # are rendered.

app.listen 8000, ->
  console.log "\nYour app is now running on port 8000\n".green.underline
