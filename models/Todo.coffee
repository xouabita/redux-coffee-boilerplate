mongoose = require 'mongoose'
{ Schema } = mongoose

todoSchema = new Schema

  content: { type: String, required: yes }

module.exports = mongoose.model 'Todo', todoSchema
