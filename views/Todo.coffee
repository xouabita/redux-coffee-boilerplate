React         = require 'react'
{ Component, PropTypes } = React
actions = require '../actions/todo'

{ connect } = require 'react-redux'
{ bindActionCreators } = require 'redux'

class Todo extends Component

  @initialData: (redux) ->
    promise = redux.dispatch(actions.getTodos()).payload
    return promise

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
              @props.todos.map (todo, i) ->
                <li key={todo._id}>{todo.content}</li>
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

module.exports = connect(mapStateToProps, mapDispatchToProps) Todo
