class TasksShow extends require('view')
  
  template: require 'tasks/templates/show'
    
  events:
    'click a[data-button="edit"]': 'edit'
    'click a[data-button="delete"]': 'delete'
    'submit #comments form': 'submitComment'
  
  render: =>
    self = @
    @settings.breadcrumbs = [
      {title: 'Home', url: '#!/'}
      {title: 'Tasks', url: '#!/tasks'}
      {title: @model.get('title'), url: '!/tasks/' + @model.id}
    ]
    
    $(@el).html @template
      model: @model
    
    @renderComments()    
    @
  
  edit: =>
    window.tasksRouter.navigate '!/tasks/' + @model.id + '/edit', true
    false
    
  delete: =>
    if confirm 'Are you sure?'
      @model.destroy
        success: (model, response) ->
          window.tasksRouter.navigate '!/tasks', true      
    
    false
  
  submitComment: (e) =>  
    e.preventDefault()
    self = @
    
    attributes = @form.extract e.target
    comments = @model.get('comments');
    comments.push
      body: attributes.body
      
    modelAttr = 
      comments: comments
    @model.save modelAttr, 
      success: (model, response) ->
        self.renderComments()
        self.$('textarea').val ''
    
    false
  
  renderComments: =>
    Comment = require('tasks/views/comment')
    
    @$('.comments-list').empty()
    for k, v of @model.get 'comments'
      commentView = new Comment
        model: @model
        index: k
        comment: v
      @$('.comments-list').append commentView.render().el
    false

module.exports = TasksShow