class TodoList.Routers.Todos extends Backbone.Router
  routes:
    '*filter': 'setFilter'

  setFilter:(param)->
    TodoList.TodoFilter = param.trim() || ''
    TodoList.todos.trigger('filter')