React = require 'react'
{ Route, DefaultRoute } = require 'react-router'
{ Provider } = require 'redux/react'

Page = require './components/Page'

Index = require './views/Index'
Todo  = require './views/Todo'

module.exports.routes =
  <Route path="/" handler={Page}>
    <DefaultRoute handler={Index} />
    <Route path="/todo" handler={Todo} />
  </Route>

module.exports.fetchDataFromRoute = (state, redux) ->

  routes   = state.routes
  promises = routes

    # Get all the views who need data
    .filter (route) ->
      if route.handler.initialData then yes
      else no

    # Return all the promises
    .map (route) ->
      return route.handler.initialData(redux)

  return Promise.all(promises)

module.exports.makeHandler = (Handler, redux) ->
  <Provider redux={redux}>
    { -> <Handler /> }
  </Provider>
