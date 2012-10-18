class TodoList.Views.Todo extends Backbone.View
  tagName:  'li'
  template: JST['todos/todo']

  initialize:->
    @model.on 'change',@render,@
    @model.on 'destroy',@remove,@
    @model.on 'visible',@toggleVisible,@

  events:
    'click .toggle':  'togglecompleted'
    'dblclick label': 'edit'
    'click .destroy': 'clear'
    'keypress .edit': 'updateOnEnter'
    'blur .edit':   'close'

  render:->
    @$el.html @template(@model.toJSON())
    @$el.toggleClass 'completed', @model.get('completed') 
    @toggleVisible()
    @input = @$('.edit')
    @

  toggleVisible:->
    @$el.toggleClass 'hidden',@isHidden()

  isHidden:->
    isCompleted = @model.get('completed')
    (!isCompleted && TodoList.TodoFilter == 'completed') || (isCompleted && TodoList.TodoFilter == 'active')

  togglecompleted:->
    @model.toggle()

  edit:->
    @$el.addClass('editing')
    @input.focus()

  clear:->
    @model.destroy()

  updateOnEnter:(e)->
    @close() if e.which == 13
        
  close:->
    value = @input.val().trim()
    if value then @model.save({ title: value }) else @clear()
    @$el.removeClass('editing')




