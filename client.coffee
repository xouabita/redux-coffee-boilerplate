# ## Entry for the client-side
React  = require 'react'
Router = require 'react-router'

{ routes, fetchDataFromRoute, makeHandler, createStore } = require './App'

# Hydrate the store with the initialState.
initialState = JSON.parse document.getElementById('initial-state').innerHTML
store = createStore initialState

# Run the Router. Each time when a route changes, all the promises
# from `fetchDataFromRoute()` will be resolved. In this way, the data
# is loaded before the route is rendered.
Router.run routes, Router.HistoryLocation, (Handler, state) ->
  fetchDataFromRoute(state, store).then ->
    React.render makeHandler(Handler, store), document.getElementById 'app'
