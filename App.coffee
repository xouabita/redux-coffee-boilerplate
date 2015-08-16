React = require 'react'
{ Route, DefaultRoute } = require 'react-router'
{ Provider } = require 'react-redux'

Page = require './components/Page'

Index = require './views/Index'
Todo  = require './views/Todo'

{ combineReducers, createStore, applyMiddleware } = require 'redux'
thunk = require 'redux-thunk'

module.exports.routes =
  <Route path="/" handler={Page}>
    <DefaultRoute handler={Index} />
    <Route path="/todo" handler={Todo} />
  </Route>

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

module.exports.makeHandler = (Handler, store) ->
  <Provider store={store}>
    { -> <Handler /> }
  </Provider>

module.exports.createStore = (initialState) ->
  reducers = require './reducers'
  reducer  = combineReducers reducers
  createStoreWithMiddleware = applyMiddleware(thunk)(createStore)

  return createStoreWithMiddleware reducer, initialState
