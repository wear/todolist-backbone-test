describe 'todo model',->
  todo = null
  beforeEach ->
    todo = new TodoList.Models.Todo

  it 'should have default value',->
    expect(todo.get('title')).toEqual('')
    expect(todo.get('completed')).toEqual(false)

  it 'should toggle completed',->
    saveStub = sinon.stub(todo,'save').withArgs({completed:true})
    todo.toggle()
    expect(saveStub).toHaveBeenCalledOnce()
