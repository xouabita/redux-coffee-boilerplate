express = require 'express'
router  = express.Router()

router.use '/todos', require './todo'

module.exports = router
