describe 'todoView',->
  todoView = null

  beforeEach ->
    todoItem = new Backbone.Model({id:1,title:'test1',completed: false})
    todoItem.toggle = -> #
    todoItem.url = '/'
    todoView = new  TodoList.Views.Todo({model:todoItem})

  describe 'hidden check',->
    it 'should return false if not completed',->  
      expect(todoView.isHidden()).toEqual(false)

    it 'should return true if completed and filter are marked completed ',->
      TodoList.TodoFilter = 'completed'
      expect(todoView.isHidden()).toEqual(true)

    it 'should return false if not completed and filter are marked active ',->
      TodoList.TodoFilter = 'active'
      todoView.model.set('completed',true)
      expect(todoView.isHidden()).toEqual(true)

  describe 'render',->
    beforeEach ->
      TodoList.TodoFilter = 'active'

    it 'should toggle completed class',->
      todoView.$el.toggleClass 'completed',true
      visibleSpy = sinon.spy(todoView,'toggleVisible')
      todoView.render()
      expect(todoView.$el.attr('class')).toEqual('')
      expect(visibleSpy).toHaveBeenCalledOnce()
      visibleSpy.restore()

    it 'should toggle hidden',->
      hiddenStub = sinon.stub(todoView,'isHidden').returns(true)
      todoView.toggleVisible()
      expect(todoView.$el).toHaveClass('hidden')
      hiddenStub.restore()

  describe 'events',->
    beforeEach ->
      todoView.render()

    it 'should toggle mark when click toggle',->
      toggleSpy = sinon.spy(todoView.model,'toggle')
      todoView.$('.toggle').trigger('click')
      expect(toggleSpy).toHaveBeenCalledOnce()
      toggleSpy.restore()

    it 'should enter edit mode when dbclick label',->
      todoView.$('label').trigger('dblclick')
      expect(todoView.$el).toHaveClass('editing')

    it 'should destroy if click .destroy',->
      destroySpy = sinon.spy(todoView.model,'destroy')
      todoView.$('.destroy').trigger('click')
      expect(destroySpy).toHaveBeenCalledOnce()

    it 'should update on enter',->
      closeSpy = sinon.spy(todoView,'close')
      e = jQuery.Event("keypress")
      e.which = 13
      todoView.$('.edit').trigger(e)
      expect(closeSpy).toHaveBeenCalledOnce()

    it 'should remove editing class when close',->
      todoView.$el.addClass('editing')
      todoView.close()
      expect(todoView).not.toHaveClass('editing')

    it 'should save when close with a edit value',->
      saveSpy = sinon.spy(todoView.model,'save')
      todoView.$('.edit').val('hello')
      todoView.close()
      expect(saveSpy).toHaveBeenCalledWith({title:'hello'})
      saveSpy.restore()

    it 'should just clear if no value',->
      clearSpy = sinon.spy(todoView,'clear')
      todoView.$('.edit').val('')
      todoView.close()
      expect(clearSpy).toHaveBeenCalledOnce()
      clearSpy.restore()


