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

router.delete '/:id', (req, res) ->
  Todo.remove _id: req.params.id, ->
    res.sendStatus 200

module.exports = router
