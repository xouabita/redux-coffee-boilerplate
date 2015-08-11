React         = require 'react'
{ Component, PropTypes } = React

class Todo extends Component

  @propTypes:
    todos: PropTypes.array.isRequired

  constructor: (props) ->
    super props

  render: ->
    <ul>
      {
        @props.todos.map (todo, i) ->
          <li key={i}>{todo}</li>
      }
    </ul>

class TodoContainer extends Component

  _todos = ['lol','xd']

  render: ->
    <Todo todos={_todos} />

module.exports = TodoContainer
