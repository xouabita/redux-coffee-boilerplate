{
  ADD_TODO
  GET_TODOS
  DELETE_TODO
  API_TODOS
  TODOS_READY
  TODOS_ERROR
} = require '../constants/todos.coffee'

Api = require '../services/Api.coffee'

module.exports.addTodo = (todo) -> (dispatch) ->
  action = dispatch
    type: API_TODOS
    payload: Api.post 'http://localhost:8000/api/todos', content: todo

  action.payload
    .then  -> dispatch type: TODOS_READY
    .catch -> dispatch type: TODOS_ERROR

  action.payload
    .then (todo) ->
      dispatch
        type: ADD_TODO
        payload: todo

module.exports.getTodos = -> (dispatch) ->
  action = dispatch
    type: API_TODOS
    payload: Api.get 'http://localhost:8000/api/todos'

  action.payload
    .then  -> dispatch type: TODOS_READY
    .catch -> dispatch type: TODOS_ERROR

  action.payload
    .then (todos) ->
      dispatch
        type: GET_TODOS
        payload: todos

  return action

module.exports.deleteTodo = (id, index) -> (dispatch) ->

  action = dispatch
    type: API_TODOS
    payload: Api.delete "http://localhost:8000/api/todos/#{id}"

  action.payload
    .then  -> dispatch type: TODOS_READY
    .catch -> dispatch type: TODOS_ERROR

  action.payload
    .then ->
      dispatch
        type: DELETE_TODO
        payload: index
