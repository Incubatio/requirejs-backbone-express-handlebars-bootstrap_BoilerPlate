define (require) ->
  (app) ->
    RestfullController = require("controllers/restfull")


    class TodoController extends RestfullController

      list:   (req, res) -> res.json(200, req.session.todos || [])

      get:    (req, res) -> res.json(200, req.session.todos[req.params.id] || {})

      create: (req, res) ->
        if req.body.msg
          c = {msg: req.body.msg}
          if !req.session.todos then req.session.todos = []
          c.id = req.session.todos.length
          req.session.todos.push(c)
        res.json(200, c)

      update: (req, res) ->
        if req.params.msg && req.params.id
          c = {msg: req.params.msg}
          req.session.todos[req.params.id] = c
        res.json(200, c)

      delete: (req, res) ->
        if req.params.id
          req.session.todos[req.params.id].msg = false
          deleted = "ok"
        res.json(200, deleted || "ko")

    return new TodoController {app: app, endpoint:'/api/todos', middleware: []}
