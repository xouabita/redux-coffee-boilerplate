React            = require 'react'
{ Component }    = React

{ RouteHandler, Link } = require 'react-router'

class Page extends Component

  constructor: (props) ->
    super props

  render: ->
    <div>
      <Link to="/">Index</Link> <Link to="/todo">Todo</Link>
      <div><RouteHandler /></div>
    </div>

module.exports = Page
