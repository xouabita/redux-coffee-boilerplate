express  = require 'express'
router   = express.Router()
co       = require 'co'

Todo = require '../models/Todo'

router.get '/', (req, res) -> co ->
  todos = yield Todo.find()
  res.json todos

router.post '/', (req, res) -> co ->
  todo = new Todo
    content: req.body.content
  yield todo.save()
  res.json todo

router.delete '/:id', (req, res) -> co ->
  yield Todo.remove _id: req.params.id
  res.sendStatus 200

module.exports = router
