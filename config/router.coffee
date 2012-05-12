class TasksRouter extends require('router')
  
  routes:
    '!/tasks': 'index'
    '!/tasks/add': 'add'
    '!/tasks/:id': 'show'
    '!/tasks/:id/edit': 'edit'
  
  constructor: (options) ->
    super
  
  index: ->
    Tasks = require 'tasks/collections/tasks'
    Index = require 'tasks/views/index'
    tasksIndexView = new Index
      collection: new Tasks
    $('#main').html tasksIndexView.render().el
  
  add: ->
    Tasks = require 'tasks/collections/tasks'
    Task  = require 'tasks/models/task'
    Form  = require 'tasks/views/form'
    
    tasksFormView = new Form
      collection: new Tasks
      model: new Task
    $('#main').html tasksFormView.render().el
  
  edit: (id) ->
    Tasks = require 'tasks/collections/tasks'
    Form  = require 'tasks/views/form'
    
    tasks = new Tasks
    tasks.fetch
      success: (collection, response) ->
        task = collection.get id
        tasksFormView = new Form
          collection: collection
          model: task
        $('#main').html tasksFormView.render().el
  
  show: (id) ->
    Tasks = require 'tasks/collections/tasks'
    Show  = require 'tasks/views/show'
    
    tasks = new Tasks
    tasks.fetch
      success: (collection, response) ->
        task = collection.get id
        tasksShowView = new Show
          collection: collection
          model: task
        $('#main').html tasksShowView.render().el
  
module.exports = TasksRouter