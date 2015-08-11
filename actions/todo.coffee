{
  ADD_TODO
  GET_TODOS
  TODOS_LOADED
  TODOS_ERROR
} = require '../constants/todos.coffee'

Api = require '../services/Api.coffee'

module.exports.addTodo = (todo) ->
  type: ADD_TODO
  payload: todo

module.exports.getTodos = -> (dispatch) ->
  action = dispatch
    type: GET_TODOS
    payload: Api.get 'http://localhost:8000/api/todos'

  action.payload
    .then (todos) -> dispatch
      type: TODOS_LOADED
      payload: todos
    .catch -> dispatch
      type: TODOS_ERROR

  return action
