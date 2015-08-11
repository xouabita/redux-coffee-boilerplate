React  = require 'react'
Router = require 'react-router'

{ createRedux } = require 'redux'

reducers = require './reducers'
{ routes, fetchDataFromRoute, makeHandler } = require './App'

initialState = JSON.parse document.getElementById('initial-state').innerHTML
redux = createRedux reducers, initialState

Router.run routes, Router.HistoryLocation, (Handler, state) ->
  fetchDataFromRoute(state, redux).then ->
    React.render makeHandler(Handler, redux), document.getElementById 'app'
