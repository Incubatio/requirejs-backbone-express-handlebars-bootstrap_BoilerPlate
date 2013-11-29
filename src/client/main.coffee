#require [ 'jquery', 'underscore', 'backbone', 'backbone.marionette', 'etc/config', 'modules/app' ],
#( $, _,  backbone, marionette, config, App) ->
require ['etc/config', 'modules/app'], (config, App) ->
  "use strict"
  

  # Config
  console.log config

  # Cookie

  # i18n

  # authentication

  # application
  myApp = new App()
