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
    @state =
      value: ''

  render: ->
    <div>
      <ul>
        {
          @props.todos.map (todo, i) ->
            <li key={i}>{todo}</li>
        }
      </ul>
      <input value={@state.value} onChange={@_onChange}/>
      <button onClick={@_addTodo}>Add Todo</button>
    </div>

  _onChange: (e) => @setState value: e.target.value

  _addTodo: =>
    @props.actions.addTodo @state.value
    @setState value: ''

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
