class TodoList.Views.App extends Backbone.View
  statsTemplate:JST['todos/statics']
  el: '#todoapp'
  events:
    'keypress #new-todo': 'createOnEnter'
    'click #clear-completed': 'clearCompleted'
    'click #toggle-all': 'toggleAllComplete'

  initialize:->
    @input = @$('#new-todo')
    @allCheckbox = @$('#toggle-all')[0]
    @$footer = @$('#footer')
    @$main = @$('#main')

    @collection.on('reset',@addAll,@)
    @collection.on('add',@addOne,@)
    @collection.on('change:completed', @filterOne, @)
    @collection.on("filter", @filterAll, @)
    @collection.on('all',@render,@)
    @collection.fetch()

  render:->
    completed = @collection.completed().length
    remaining = @collection.remaining().length

    if @collection.length 

      @$main.show()
      @$footer.show()

      @$footer.html(@statsTemplate({completed: completed,remaining: remaining}))

      @$('#filters li a')
        .removeClass('selected')
        .filter('[href="#/' + ( TodoList.TodoFilter || '' ) + '"]')
        .addClass('selected');
    else
      @$main.hide()
      @$footer.hide()

    @allCheckbox.checked = !remaining

  addOne:(todo)->
    view = new TodoList.Views.Todo({ model: todo })
    $('#todo-list').append(view.render().el)

  addAll:->
    @$('#todo-list').html('')
    @collection.each(@addOne, @)

  filterOne:(todo)->
    todo.trigger("visible")

  filterAll:->
    @collection.each(@filterOne, @)

  newAttributes:->
    {
      title: this.input.val().trim(),
      # order: @collection.nextOrder(),
      completed: false
    }
  createOnEnter: (e)->
    if e.which != 13 || !@input.val().trim()
      return
    @collection.create(@newAttributes())
    @input.val('')

  clearCompleted:->
    _.each @collection.completed(),(todo)-> todo.destroy()
    false

  toggleAllComplete:->
    completed = @allCheckbox.checked
    @collection.each (todo)-> todo.save({'completed': completed})