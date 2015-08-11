express = require 'express'
colors  = require 'colors'
ejs     = require 'ejs'
React   = require 'react'
fs      = require 'fs'

app = express()

{ routes } = require './App'

base_html = fs.readFileSync './__dist__/base.html', 'utf-8'
Router    = require 'react-router'

app.use '/api', require './api'
app.use (req, res, next) ->

  router = Router.create
    location: req.url
    routes: routes

  router.run (Handler, state) ->

    html = React.renderToString <Handler />

    res.send ejs.render base_html,
      react: html
      metas: []
      state: JSON.stringify {}

app.listen 8000, -> console.log "\nYour app is now running on port 8000\n".green.underline
