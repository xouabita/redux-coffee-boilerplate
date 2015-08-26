{
  ADD_TODO
  GET_TODOS
  DELETE_TODO
} = require '../constants/todos.coffee'

Api = require '../services/Api.coffee'
co  = require 'co'

module.exports.addTodo = (todo) -> (dispatch) -> co ->

  todo_result = yield Api.post 'http://localhost:8000/api/todos', content: todo
  dispatch
    type: ADD_TODO
    payload: todo_result

module.exports.getTodos = -> (dispatch) -> co ->

  todos = yield Api.get 'http://localhost:8000/api/todos'
  dispatch
    type: GET_TODOS
    payload: todos

module.exports.deleteTodo = (id, index) -> (dispatch) -> co ->

  yield Api.delete "http://localhost:8000/api/todos/#{id}"
  dispatch
    type: DELETE_TODO
    payload: index
