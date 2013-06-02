window.TinyRssReader.Models.Entry = class Entry extends Backbone.Model
  constructor: ->
    super
    @url = '/entries/' + @get('id')

  markAsRead: ->
    @save unread: false
  markAsUnread: ->
    @save unread: true

  toggleUnread: ->
    @save unread: !@get('unread')

  # sync: (method, model, options) ->
  #   console.log arguments
  #   window.a = [@, arguments]
