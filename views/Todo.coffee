# ## Example of component which need data.

React         = require 'react'
{ Component, PropTypes } = React
actions = require '../actions/todo'

{ connect } = require 'react-redux'
{ bindActionCreators } = require 'redux'

class Todo extends Component

  # The `initialData` method return a promise. It need to be resolved
  # before the route render.
  @initialData: (state) ->
    promise = state.dispatch(actions.getTodos()).payload
    return promise

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

mapStateToProps    = (state) ->
  todos: state.todo.todos
mapDispatchToProps = (dispatch) -> actions: bindActionCreators actions, dispatch

# We use connect from react-redux to connect the data.
module.exports = connect(mapStateToProps, mapDispatchToProps) Todo
