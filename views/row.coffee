class TasksRow extends require('view')
  
  template: require 'tasks/templates/row'
  
  tagName: 'tr'
    
  events:
    'click a[data-button="show"]': 'show'
    'click a[data-button="edit"]': 'edit'
    'click a[data-button="delete"]': 'delete'
    'click span.badge': 'show'
  
  render: =>
    $(@el).html @template
      model: @model
    
    if @model.get('done')
      @$('td:first span').addClass 'strike'  
    
    @
  
  show: =>
    window.tasksRouter.navigate '!/tasks/' + @model.id, true
    false
  
  edit: =>
    window.tasksRouter.navigate '!/tasks/' + @model.id + '/edit', true
    false
    
  delete: =>
    self = @
    if confirm 'Are you sure?'
      @model.destroy
        success: (model, respone) ->
          self.remove()
          window.tasksRouter.navigate '!/tasks', true
    false

module.exports = TasksRow