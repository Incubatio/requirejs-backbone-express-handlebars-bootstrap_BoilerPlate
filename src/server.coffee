requirejs = require "requirejs"

# 1. Simple mapping of folder architecture to namespace
requirejs.config({
    nodeRequire: require

    paths:
      controllers: "server/controllers"
      views:       "server/views"
      etc:         "server/etc"
      services:    "server/domain/services"
      models:      "server/domain/models"
      constants:   "server/domain/constants"
})

requirejs ['express', 'http', 'etc/config', 'mongodb', 'mongoose', 'path'],
(express, http, config, mongo, mongoose, path) ->
  app = express()

  # 2. Classic express configuration
  app.configure () ->
    app.set('port', process.env.PORT || config.PORT || 8080)
    app.set('views', __dirname + '/../src/server/views')
    app.set('view engine', 'hjs')
    app.use(express.favicon())
    app.use(express.logger('dev'))
    app.use(express.bodyParser())
    app.use(express.methodOverride())
    app.use(require('less-middleware')({ src: __dirname + '/../public' }))
    app.use(express.static(path.join(__dirname, '/../public')))
    app.use(express.cookieParser())
    app.use(express.session({secret: 'iSleptWithYourSister'}))

  app.configure 'development', () ->
    app.use(express.errorHandler())

  # 3. Init ressources
  # TODO: move resources in a bootstrap ?
  mongo.Db.connect config.mongo.uri, (err, db_client) ->
    if err then console.log err
    else mongoose.connection = db_client
    #mongoose.connection.once 'open', () ->
    #  mongoose.connect config.mongo.uri

    controllers = ['index', 'npm', 'todo'].map( (name) -> "controllers/" + name)
    requirejs controllers, (args...) ->
      # 4. set up controllers
      for controller in args then controller(app, require)

      #5. listen http on a specific port
      http.createServer(app).listen app.get('port'), () ->
        console.log("Express server listening on port " + app.get('port'))
