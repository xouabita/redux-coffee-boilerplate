express = require 'express'
router  = express.Router()

router.get '/', (req, res) ->

  res.json [
    "Hello World!"
    "Eat food"
  ]

module.exports = router
