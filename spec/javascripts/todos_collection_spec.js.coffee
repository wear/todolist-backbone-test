describe 'todos collection',->
  todos = null

  beforeEach ->
    todo1 = new Backbone.Model({id:1,title:'test1',completed: false})
    todo2 = new Backbone.Model({id:2,title:'test2',completed: false})
    todo3 = new Backbone.Model({id:3,title:'test3',completed: true})
    todos = new TodoList.Collections.Todos([todo1,todo2,todo3])

  it 'should filter completed',->
    expect(todos.completed().length).toEqual(1)

  it 'should filter remaining',->
    expect(todos.remaining().length).toEqual(2)
