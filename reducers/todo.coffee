{
  ADD_TODO
  GET_TODOS
  DELETE_TODO
} = require '../constants/todos.coffee'

Immutable = require 'immutable'

initialState =
  todos: []
  status: 'READY'

todos = (state, action) ->

  state = if state then state else initialState
  state = Immutable.fromJS state

  switch action.type

    when ADD_TODO
      todos = state.get 'todos'
      todos = todos.push action.payload
      state = state.merge
        todos: todos
    when GET_TODOS
      state = state.merge
        todos: action.payload
    when DELETE_TODO
      todos = state.get 'todos'
      todos = todos.splice action.payload, 1
      state = state.merge
        todos: todos

  return state.toJS()

module.exports = todos
