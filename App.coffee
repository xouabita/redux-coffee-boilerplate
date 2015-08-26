# ## Entry of the universal app
#
# `App.coffee` contains some methods that can run both on server
# and browser.

React = require 'react'
{ Route, DefaultRoute } = require 'react-router'
{ Provider } = require 'react-redux'

Page = require './components/Page'

Index = require './views/Index'
Todo  = require './views/Todo'

{ combineReducers, createStore, applyMiddleware } = require 'redux'
thunk = require 'redux-thunk'

# Here we define our routes. We have two routes: the default route is
# handled by `Index` component and `/todo` route is handled by `Todo` component.
module.exports.routes =
  <Route path="/" handler={Page}>
    <DefaultRoute handler={Index} />
    <Route path="/todo" handler={Todo} />
  </Route>

# The method `fetchDataFromRoute` is where all the magic happens.
# Each handler can have a specific static method `initialData()`
# which returns a Promise and fill our reducers with the data required.
# This method returns a `Promise.all` with all the promises required by the
# route handlers.
# When all the data is loaded, we render all the components.
module.exports.fetchDataFromRoute = (state, store) ->

  routes   = state.routes
  promises = routes

    # Get all the views who need data
    .filter (route) ->
      wrapped = route.handler.WrappedComponent
      if wrapped and wrapped.initialData then yes
      else no

    # Return all the promises
    .map (route) ->
      return route.handler.WrappedComponent.initialData(store)

  return Promise.all(promises)

# The method makeHandler connects a Handler with the redux store.
module.exports.makeHandler = (Handler, store) ->
  <Provider store={store}>
    { -> <Handler /> }
  </Provider>

# This method combines all the reducers into one, add the different
# redux middlewares and hydrate the store with `initialState`.
module.exports.createStore = (initialState) ->
  reducers = require './reducers'
  reducer  = combineReducers reducers
  createStoreWithMiddleware = applyMiddleware(thunk)(createStore)

  return createStoreWithMiddleware reducer, initialState
