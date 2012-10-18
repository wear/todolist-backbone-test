class TodoList.Collections.Todos extends Backbone.Collection

  model: TodoList.Models.Todo
  url: '/todos'

  completed:->
    @filter (todo)-> 
      todo.get('completed')

  remaining:->
    @without.apply(@,@completed())
