express  = require 'express'
router   = express.Router()

Todo = require '../models/Todo'

router.get '/', (req, res) ->
  Todo.find (err, docs) ->
    res.json docs

router.post '/', (req, res) ->
  todo = new Todo
    content: req.body.content
  todo.save()
  res.json todo

module.exports = router
