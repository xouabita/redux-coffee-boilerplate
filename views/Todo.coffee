React         = require 'react'
{ Component, PropTypes } = React
actions = require '../actions/todo'

{ Connector } = require 'redux/react'
{ bindActionCreators } = require 'redux'

class Todo extends Component

  @propTypes:
    todos: PropTypes.array.isRequired
    actions: PropTypes.object

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

  @initialData: (redux) ->
    promise = redux.dispatch(actions.getTodos()).payload
    return promise

  render: ->
    <Connector select={(state) -> todos: state.todo.todos}>
      {
        (state) ->
          bindedActions = bindActionCreators actions, state.dispatch
          <Todo todos={state.todos} actions={bindedActions} />
      }
    </Connector>

module.exports = TodoContainer
