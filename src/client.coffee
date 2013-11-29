require.config({

    baseUrl: 'build/client'

    paths:
      templates:   '../../assets/js/templates'
      etc:         'etc'
      modules:     'modules'

      underscore:             '/npm/underscore'
      backbone:               '/npm/backbone'
      'backbone.marionette':  '/npm/backbone.marionette'
      'backbone.wreqr':       '/npm/backbone.wreqr'
      'backbone.babysitter':  '/npm/backbone.babysitter'
      jquery:                 '/npm/jquery1-browser'
      'jquery.cookie':        '/npm/jquery.cookie'
      bootstrap:              '/npm/bootstrap-browser'
      json2:                  '/npm/json2-browser'
      hbs:                    '/npm/hbs-browser'
      handlebars:             '/npm/handlebars-browser'
      i18n:                   '/assets/js/vendor/i18n'
      i18nprecompile:         '/assets/js/vendor/i18nprecompile'

    shim:
      underscore: {exports : '_'}
      backbone:
        exports: 'Backbone'
        deps: ['json2', 'jquery', 'bootstrap', 'underscore']
      'backbone.wreqr': {deps:['backbone']}
      'backbone.babysitter': {deps:['backbone']}
      'backbone.marionette': {deps:['backbone']}
      handlebars: {exports: 'Handlebars'}
      json2: {exports: 'JSON'}
      bootstrap: {deps: ['jquery']}

    hbs:
      disableI18n: true
      disableHelpers: true
      helperPathCallback: (name) -> 'hbs!' + name
      templateExtension: "html"
      compileOptions: {}
})
