class TodoList.Models.Todo extends Backbone.Model
  defaults:
    title: ''
    completed: false

  toggle:->
    @save {completed:!this.get('completed')}
