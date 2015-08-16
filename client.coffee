React  = require 'react'
Router = require 'react-router'

{ routes, fetchDataFromRoute, makeHandler, createStore } = require './App'

initialState = JSON.parse document.getElementById('initial-state').innerHTML
store = createStore initialState

Router.run routes, Router.HistoryLocation, (Handler, state) ->
  fetchDataFromRoute(state, store).then ->
    React.render makeHandler(Handler, store), document.getElementById 'app'
