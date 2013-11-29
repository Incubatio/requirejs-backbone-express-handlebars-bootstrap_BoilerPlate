define (require) ->
  backbone = require('backbone')
  marionette = require('backbone.marionette')
  pongTemplate = require('hbs!templates/app/pong')
  getTemplate = require('hbs!templates/todo/dialog-get')
  formTemplate = require('hbs!templates/todo/dialog-form')
  listTemplate = require('hbs!templates/todo/dialog-list')

  class ModalRegion extends marionette.Region
    el: '#modal-content'

    initialize: () ->
      @container = $("#modal-dialog")
      @container.html('<div id="modal-overlay"></div><div id="modal-content"></div>')

    onShow: () ->
      $(@el).prepend( '<div class="close-back"> <a href="javascript:void(0)" class="btn close"><i class="icon-remove"></i>x</a></div>')
      @container.fadeIn(200)

    onClose: () ->
      @container.fadeOut(200)

  class TodoModel extends Backbone.Model
    urlRoot: '/api/todos'
    idAttribute: 'id'

  class TodoCollection extends backbone.Collection
    model: TodoModel
    url: '/api/todos'

  class TodoFormView extends marionette.ItemView
    template: formTemplate
    className: "todoForm"

  class TodoView extends marionette.ItemView
    template: getTemplate
    tagName: "li"

  class TodoCollectionView extends marionette.CompositeView
    template: listTemplate
    itemView: TodoView
    itemViewContainer: '#todos'
    emptyView: () ->
      new marionette.ItemView({tagName: "li", template: () -> "Add a new task with the link below !"})

    showCollection: () ->
      @collection.each (item, index) =>
        if item.get("msg")
          ItemView = @getItemView(item)
          @addItemView(item, ItemView, index)


  class HelloWorldView extends Backbone.View
    render: () -> @el = "<h1>Hello World</h1>"

  class PongView extends marionette.ItemView
    template: pongTemplate
    data: {array: [10, 20, 30, 40, 50] }
    serializeData: () ->
      if(this.model) then data = this.model.toJSON()
      else if (this.collection) then data = { items: this.collection.toJSON() }

      data = _.extend(@data, data)
      data = _.extend(data, {i18n: @i18n})
      return data

    tagName: 'h2'

  class AppLayout extends marionette.Layout

    initialize: () ->
      #@header.show(new TestView())
      #@main.show(new TestView)
      #app.main.show(new SliderView)
      #app.footer.show(new FooterView)

    el: 'body'

    regions:
      header: '#header',
      main:   '#main',
      footer: '#footer',

    events:
      #'click .nav a': (e) -> $(e.target).tab('show')
      'click #home': (e) -> @main.show(new HelloWorldView)
      'click #ping': (e) -> @main.show(new PongView)
      'click #modal': (e) -> @modal.show(@options.app.todoCollectionView )
      'click #modal-dialog .btn.new': (e) -> @modal.show(new TodoFormView)
      'click #modal-dialog .btn.close': (e) -> @modal.close()
      'click #modal-overlay': (e) -> @modal.close()
      'click #modal-dialog .btn.delete': (e) ->
        todo = @options.app.todoCollection.get($(e.target).attr("value"))
        @options.app.todoCollection.remove(todo)

      'click #modal-dialog .btn.submit': (e) ->
        form = $(".todoForm").find('input')
        todo = new TodoModel({msg: form.val()})
        form.val("")
        todo.save {}, { success: (todo) =>
          @options.app.todoCollection.add(todo)
          @modal.show(@options.app.todoCollectionView )
        }
        

  class App
    modalRegion: null

    constructor: () ->
      @modalRegion = new ModalRegion()

      @todoCollection = new TodoCollection()

      @todoCollection.fetch { success: () =>
        @todoCollectionView = new TodoCollectionView({ collection: @todoCollection})
        @todoCollectionView.render()
        @todoCollection.on('add change remove', (todo) => @todoCollectionView.render() )
        @todoCollection.on('remove', (todo) => todo.destroy())
      }

      layout = new AppLayout({app: @})
      layout.addRegion('modal', @modalRegion)
