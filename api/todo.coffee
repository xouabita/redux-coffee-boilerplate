express  = require 'express'
router   = express.Router()

Todo = require '../models/Todo'

router.get '/', (req, res) ->
  Todo.find (err, docs) ->
    res.json docs

module.exports = router
