# ## Entry for the client-side
React  = require 'react'
Router = require 'react-router'
co     = require 'co'

{ routes, fetchDataFromRoute, makeHandler, createStore } = require './App'

# Hydrate the store with the initialState
initialState = JSON.parse document.getElementById('initial-state').innerHTML
store = createStore initialState

# Run the Router. Each time the route change, all the promises
# from fetchDataFromRoute are resolved. Like that the data is loaded
# before the route is rendered.
Router.run routes, Router.HistoryLocation, (Handler, state) -> co ->
  yield fetchDataFromRoute(state, store)
  React.render makeHandler(Handler, store), document.getElementById 'app'
