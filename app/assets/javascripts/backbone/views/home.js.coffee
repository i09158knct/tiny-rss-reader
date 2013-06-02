TRR = window.TinyRssReader
TRR.Views.Home = class Home extends Backbone.View
  el: '.main'
  events:
    'click .': ''
    'click .fold_all': 'foldAll'
    'click .expand_all': 'unfoldAll'
    'click .mark_all_as_read': 'markAllAsRead'

  constructor: ->
    super
    @entries = new TRR.Views.Entries()
