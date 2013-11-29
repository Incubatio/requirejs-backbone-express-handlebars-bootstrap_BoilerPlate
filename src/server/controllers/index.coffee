define (require) ->
  (app) ->
    app.get "/", (req, res) ->
      res.render("index")
