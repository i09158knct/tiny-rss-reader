window.TinyRssReader.Views.Entry = class Entry extends Backbone.View
  events:
    'click .head': 'onHeadClick'
    'click .mark_as_read': 'markAsRead'
    'click .mark_as_unread': 'markAsUnread'


  constructor: ->
    super
    @listenTo @model, 'change', @render

  render: ->
    @$el.toggleClass('unread', @model.get('unread'))
    return @


  onHeadClick: ->
    @trigger 'headclick', @

  markAsRead: ->
    @model.markAsRead()
  markAsUnread: ->
    @model.markAsUnread()

  fold: ->
    @$el.addClass('folded')
  unfold: ->
    @$el.removeClass('folded')

  focus: ->
    @$el
      .addClass('current')
      .removeClass('folded')
  unfocus: ->
    @$el
      .removeClass('current')
      .addClass('folded')
