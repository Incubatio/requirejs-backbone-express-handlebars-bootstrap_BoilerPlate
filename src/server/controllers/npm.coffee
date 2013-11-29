define (requirejs) ->
  (app, require) ->
    charset = "utf8"
    type = "application/javascript"
    fs = require('fs')
    
    app.get "/npm/:script([a-zA-Z1-9-.]+).js", (req, res) ->
      try
        filename = require.resolve(req.params.script)

        res.setHeader('Content-Type', type + (charset ? '; charset=' + charset : ''))
        #res.send("<html><pre>" + fs.readFileSync(filename).toString())
        res.send(fs.readFileSync(filename))
      catch err
        res.status(404).send('Not found')
