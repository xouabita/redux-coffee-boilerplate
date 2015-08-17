{
  ADD_TODO
  API_TODOS
  GET_TODOS
  TODOS_READY
  TODOS_ERROR
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

    # API actions
    when API_TODOS
      state = state.merge
        promise: action.payload
        status: 'PENDING'
    when TODOS_READY
      state = state.merge
        promise: undefined
        status: 'READY'
    when TODOS_ERROR
      state = state.merge
        promise: undefined
        status: 'ERROR'

  return state.toJS()

module.exports = todos
