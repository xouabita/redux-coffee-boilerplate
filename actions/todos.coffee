{
  ADD_TODO
  GET_TODOS
  TODOS_LOADED
  TODOS_ERROR
} = require '../constants/todos.coffee'

request = require 'superagent'
{ Promise } = require 'es6-promise'

module.exports.addTodo = (todo) ->
  type: ADD_TODO
  payload: todo

module.exports.getTodos = -> (dispatch) ->
  action = dispatch
    type: GET_TODOS
    payload: request.get '/api/album'

  action.payload
    .then (todos) -> dispatch
      type: TODOS_LOADED
      payload: JSON.parse todos.text
    .catch -> dispatch
      type: TODOS_ERROR

  return action
