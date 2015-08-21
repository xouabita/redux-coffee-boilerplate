# ## Entry of the universal app
#
# `App.coffee` contains some methods helpers that can run both on server
# and browser

React = require 'react'
{ Route, DefaultRoute } = require 'react-router'
{ Provider } = require 'react-redux'

# This the page component. It contains only the menu.
Page = require './components/Page'

# This is our views
Index = require './views/Index'
Todo  = require './views/Todo'

{ combineReducers, createStore, applyMiddleware } = require 'redux'
thunk = require 'redux-thunk'

# Here we define our routes. We have two routes, the default route is
# is handled by Index component and `/todo` route handled by Todo component.
module.exports.routes =
  <Route path="/" handler={Page}>
    <DefaultRoute handler={Index} />
    <Route path="/todo" handler={Todo} />
  </Route>

# The methods `fetchDataFromRoute` is where happen all the magic.
# Each handler can have a specific static method `initialData()`
# which return a Promise and fill our reducers with the data required.
# This method return a Promise.all with all the promises required by the
# route handlers.
# When all the data is loaded we render the app.
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

# The method makeHandler connect a Handler with the redux store.
module.exports.makeHandler = (Handler, store) ->
  <Provider store={store}>
    { -> <Handler /> }
  </Provider>

# This method combine all the reducers into one, add the different
# redux middlewares and hydrate the store with `initialState`
module.exports.createStore = (initialState) ->
  reducers = require './reducers'
  reducer  = combineReducers reducers
  createStoreWithMiddleware = applyMiddleware(thunk)(createStore)

  return createStoreWithMiddleware reducer, initialState
