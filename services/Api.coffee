request     = require 'superagent'
{ Promise } = require 'es6-promise'
assign      = require 'object-assign'

_handle_error = (res, reject) ->
  r = {}
  if res
    r = status: res.status
    assign r, JSON.parse res.text
  reject r

Api =
  get: (url) ->
    new Promise (resolve, reject) ->
      request
        .get url
        .end (err, res) ->
          if err then _handle_error res, reject
          resolve JSON.parse res.text

  post: (url, data) ->
    new Promise (resolve, reject) ->
      request
        .post url
        .send data
        .set 'Content-Type', 'application/json'
        .end (err, res) ->
          if err then _handle_error res, reject
          resolve JSON.parse res.text

  delete: (url) ->
    new Promise (resolve, reject) ->
      request
        .del url
        .end (err, res) ->
          if err then _handle_error res, reject
          resolve()

module.exports = Api
