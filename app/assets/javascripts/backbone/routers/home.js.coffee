TRR = window.TinyRssReader
TRR.Routers.Home = class Home extends Backbone.Router
  routes:
    '(index)'       : 'index'
    'all'           : 'all'
    ':id'           : 'show'

  constructor: () ->
    super
    @main = new TRR.Views.Home()


  index: ->
    console.log 'index'

  all: ->
    console.log 'all'

  show: (id) ->
    console.log 'show ' + id
