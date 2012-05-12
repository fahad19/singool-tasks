class TasksComment extends require('view')
  
  className: 'well'
  
  template: require 'tasks/templates/comment'
  
  events:
    'click a.close': 'destroy'
  
  render: =>
    $(@el).html @template
      comment: @settings.comment
    @
  
  destroy: =>
    self = @
    comments = @model.get 'comments'
    comments.splice @settings.index, 1
    attributes = 
      comments: comments
    @model.save attributes, 
      success: (model, response) ->
        self.remove()
    
    false
    

module.exports = TasksComment