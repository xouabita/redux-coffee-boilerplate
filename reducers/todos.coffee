{
  ADD_TODO
  GET_TODOS
  TODOS_LOADED
  TODOS_ERROR
} = require '../constants/todos.coffee'

Immutable = require 'immutable'

initialState =
  todos: []
  status: 'LOADED'

todos = (state, actions) ->

  state = if state then state else initialState
  state = Immutable.fromJS state

  switch action.type

    when ADD_TODO then state = state.push action.payload
    when GET_TODOS
      state = state.merge
        promise: action.payload
        status: 'PENDING'
    when TODOS_LOADED
      state = state.merge
        promise: undefined
        status: 'LOADED'
        todos: action.payload
    when TODOS_ERROR
      state = state.merge
        promise: undefined
        status: 'ERROR'

  return state.toJS()

module.exports = todos
