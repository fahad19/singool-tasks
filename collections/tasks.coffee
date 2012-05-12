class Tasks extends require('collection')
  
  model: require 'tasks/models/task'
  
  localStorage: new Store 'tasks'

module.exports = Tasks