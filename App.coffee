React = require 'react'
{ Route, DefaultRoute } = require 'react-router'

Index = require './views/Index'
Todo  = require './views/Todo'

module.exports.routes =
  <Route path="/">
    <DefaultRoute handler={Index} />
    <Route path="todo" handler={Todo} />
  </Route>
