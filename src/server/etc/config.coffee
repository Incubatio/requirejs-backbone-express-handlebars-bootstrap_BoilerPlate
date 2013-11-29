define (require) ->
  return {
    PORT: 8080
    mongo:
      uri: "mongodb://localhost/test"
  }
