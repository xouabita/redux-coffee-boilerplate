# ## Entry for server-side
express = require 'express'
colors  = require 'colors'
ejs     = require 'ejs'
React   = require 'react'
fs      = require 'fs'
co      = require 'co'

mongoose = require 'mongoose'
mongoose.connect 'mongodb://localhost/redux_coffee_boilerplate'

app = express()

bodyParser = require 'body-parser'
app.use bodyParser.json()

{ routes, fetchDataFromRoute, makeHandler, createStore } = require './App'

base_html = fs.readFileSync './__dist__/base.html', 'utf-8'
Router    = require 'react-router'

app.use '/api', require './api'
app.use (req, res, next) ->

  router = Router.create
    location: req.url
    routes: routes

  store = createStore()
  router.run (Handler, state) -> co ->
    yield fetchDataFromRoute(state, store)
    initialState = store.getState()
    handler      = makeHandler Handler, store
    html         = React.renderToString handler
    res.send ejs.render base_html,
      metas: []
      state: JSON.stringify initialState
      react: html

app.listen 8000, ->
  console.log "\nYour app is now running on port 8000\n".green.underline
