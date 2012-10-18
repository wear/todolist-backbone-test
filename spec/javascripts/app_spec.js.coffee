describe 'app',->
  appView = null
  fetchStub = null

  beforeEach ->
    loadFixtures 'app'
    todo1 = new Backbone.Model({id:1,title:'test1',completed: false})
    todo2 = new Backbone.Model({id:2,title:'test2',completed: false})
    todo3 = new Backbone.Model({id:3,title:'test3',completed: true})
    todos = new Backbone.Collection([todo1,todo2,todo3])
    todos.nextOrder = -> 1
    todos.url = '/'
    fetchStub = sinon.stub(todos,'fetch')
    appView = new TodoList.Views.App({collection:todos})

  afterEach ->
    fetchStub.restore()

  describe 'init',->
    it 'should set input',->
      expect(appView.input).toHaveId('new-todo')

    it 'should fetch todos',->
      expect(fetchStub).toHaveBeenCalledOnce()

  describe 'render',->
    it 'should show static if have todos',->
      appView.collection.completed = -> 
        appView.collection.where({completed:true})
      appView.collection.remaining = -> 
        appView.collection.where({completed:false})
      appView.render()
      expect(appView.$main).toBeVisible()
      expect(appView.$footer).toBeVisible()
      expect($("#todo-count strong")).toHaveText('2')

    it 'should hide static if no todos',->
      appView.collection = new Backbone.Collection
      appView.collection.completed = -> []
      appView.collection.remaining = -> []
      appView.render()
      expect(appView.$main).toBeHidden()

  describe 'add',->
    it 'should empty item list when add all',->
      appView.$('#todo-list').html('test')
      eachStub = sinon.stub(appView.collection,'each')
      appView.addAll()
      expect(appView.$('#todo-list').html()).toEqual('')
      expect(eachStub).toHaveBeenCalledOnce()

    it 'should add one item',->
      todo = new Backbone.Model({id:1,title:'test1',completed: false})
      todoView = new Backbone.View({model:todo})
      todoView.render = ->
        @$el.html("<li>"+@model.get('title')+"</li>")
        @
      viewStub = sinon.stub(TodoList.Views,'Todo').returns(todoView)
      appView.addOne(todo)
      expect(viewStub).toHaveBeenCalledOnce()
      expect($('#todo-list')).toHaveText('test1')
      viewStub.restore()

  it 'should set new attributes',->
    appView.input.val('testTitle')
    attrs = appView.newAttributes()
    expect(attrs.title).toEqual('testTitle')
    expect(attrs.completed).toBe(false)

  it 'should clear input value when press enter key',->
    addStub = sinon.stub(appView.collection,'add')
    appView.input.val('test')
    e = jQuery.Event("keypress")
    e.which = 13
    createSpy = sinon.spy(appView.collection,'create')
    appView.$('#new-todo').trigger(e)
    expect(appView.input.val()).toEqual('')
    expect(createSpy).toHaveBeenCalledOnce()
    expect(addStub).toHaveBeenCalledOnce()

  describe 'action',->
    beforeEach ->
      appView.collection.completed = -> 
        appView.collection.where({completed:true})
      appView.collection.remaining = -> 
        appView.collection.where({completed:false})

    it 'should clear-completed when click complete',->
      mocks = []
      _.each appView.collection.completed(),(todo)-> mocks.push(sinon.mock(todo,'destroy'))
      appView.$('#clear-completed').trigger('click')
      _.each mocks,(m)-> expect(m.verify()).toBe(true)

    it 'should toggleAllComplete',->
      appView.allCheckbox.checked = true
      mocks = []
      appView.collection.each (todo)-> mocks.push(sinon.mock(todo,'save'))
      appView.$('#toggle-all').trigger('click')
      _.each mocks,(m)-> expect(m.verify.toBe(true)



