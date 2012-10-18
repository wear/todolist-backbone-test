window.TodoList =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  app: {}
  init: -> 
    todos = new TodoList.Collections.Todos
    app = new TodoList.Views.App(collection:todos)
    TodoList.todos = app.collection
    TodoList.TodoRouter = new TodoList.Routers.Todos
    Backbone.history.start()

$(document).ready ->
  TodoList.init()

