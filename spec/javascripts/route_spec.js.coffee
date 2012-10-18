describe 'route',->
  app = null

  beforeEach ->
    try 
      TodoList.TodoRouter = new TodoList.Routers.Todos
      Backbone.history.start()
    catch e

  it 'shuold trigger filter',->
    triggerStub = sinon.stub(TodoList.todos,'trigger')
    TodoList.TodoRouter.navigate('active', {trigger: true})
    expect(TodoList.TodoFilter).toEqual('active')
    expect(triggerStub).toHaveBeenCalledOnce()
    triggerStub.restore()


    