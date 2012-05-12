class TasksForm extends require('view')

  template: require 'tasks/templates/form'

  events: 
    'submit form': 'submit'
    'click button[type="reset"]': 'reset'

  render: =>
    @settings.breadcrumbs = [
      {title: 'Home', url: '#!/'}
      {title: 'Tasks', url: '#!/tasks'}
    ]

    if @model.isNew()
      @settings.breadcrumbs.push({title: 'Add', url: '#'})
    else
      @settings.breadcrumbs.push({title: 'Edit', url: '#'})

    $(@el).html @template()

    @

  submit: (e) =>
    e.preventDefault()
    attributes = @model.extract e.target

    if @model.isNew()
      if !@model.set attributes
        @form.showErrors e.target, @model
      else
        @collection.create @model
        window.tasksRouter.navigate '!/tasks', true
    else
      @model.save attributes, 
        error: (model, response) =>
          @form.showErrors e.target, model
        success: (model, response) ->
          window.tasksRouter.navigate '!/tasks', true

    false

  reset: =>
    window.tasksRouter.navigate '!/tasks', true
    false

module.exports = TasksForm
