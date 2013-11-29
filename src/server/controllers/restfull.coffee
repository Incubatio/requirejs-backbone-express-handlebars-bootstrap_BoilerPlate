define (require) ->
  extend = require('lodash').extend

  class RestfullController

    constructor: (options) ->
      {@endpoint, @app, @middleware} = extend @defaults, options
      if @middleware.length
        bindedMiddleware = @middleware.map (middleware) =>
          () => middleware.apply(@, arguments)
        @app.all.apply(@app, [@endpoint].concat bindedMiddleware)
        @app.all.apply(@app, [@endpoint + '/*'].concat bindedMiddleware)
      @app.get(   @endpoint,          () => @list.apply(@, arguments))
      @app.get(   @endpoint + '/:id', () => @get.apply(@, arguments))
      @app.post(  @endpoint,          () => @create.apply(@, arguments))
      @app.put(   @endpoint + '/:id', () => @update.apply(@, arguments))
      @app.delete(@endpoint + '/:id', () => @delete.apply(@, arguments))

    defaults:
      endpoint: ''
      middleware: []

    #default response
    notAvailableMethod: (req, res) ->
      res.json(405, {
        error: "Method not allowed",
        errorCode: 405,
        errorMessage: "This HTTP method is not allowed on this endpoint"
      })

    #restfull actions to ovveride
    list:   (req, res) -> @notAvailableMethod(req, res)
    get:    (req, res) -> @notAvailableMethod(req, res)
    create: (req, res) -> @notAvailableMethod(req, res)
    update: (req, res) -> @notAvailableMethod(req, res)
    delete: (req, res) -> @notAvailableMethod(req, res)

  #module.exports = RestfullController
