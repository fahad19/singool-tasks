class TasksIndex extends require('view')
  
  template: require 'tasks/templates/index'
  
  defaultSettings:
    breadcrumbs: [
      {title: 'Home', url: '#!/'}
      {title: 'Tasks', url: '#!/tasks'}
    ]
    
  events:
    'click a[data-button="add"]': 'add'
  
  constructor: (options) ->
    super
    @collection.bind 'reset', @renderList
  
  render: =>
    $(@el).html @template()
    
    @collection.fetch()
    @
  
  renderList: =>
    self = @
    @$('tbody').empty()
    Row = require 'tasks/views/row'
    @settings.collection.each (model) ->
      model.rowView = new Row
        model: model
      self.$('table tbody').append model.rowView.render().el

    if @settings.collection.length == 0
      @$('table').hide()
      @$('.alert-info').show()

    true

  add: =>
    window.tasksRouter.navigate '!/tasks/add', true
    false

module.exports = TasksIndex
