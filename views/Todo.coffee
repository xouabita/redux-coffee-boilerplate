# ## Example of component which need data.

React         = require 'react'
{ Component, PropTypes } = React
actions = require '../actions/todo'

{ connect } = require 'react-redux'
{ bindActionCreators } = require 'redux'

co = require 'co'

class Todo extends Component

  # The `initialData` method return a promise. It need to be resolved
  # before the route render.
  @initialData: (state) -> co ->
    yield state.dispatch(actions.getTodos())

  @propTypes:
    todos: PropTypes.arrayOf(
      PropTypes.shape
        _id: PropTypes.string.isRequired
        content: PropTypes.string.isRequired
    ).isRequired
    actions: PropTypes.object

  constructor: (props) ->
    super props
    @state =
      value: ''

  render: ->
    <div>
      {
        if @props.todos.length
          <ul>
            {
              @props.todos.map (todo, i) =>
                <li key={todo._id}>
                  {todo.content}
                  <button
                    onClick={ =>
                      @props.actions.deleteTodo(todo._id, i)
                    }>delete
                  </button>
                </li>
            }
          </ul>
        else
          <div><i>No Todos yet!</i></div>
      }
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
