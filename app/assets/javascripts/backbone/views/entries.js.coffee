TRR = window.TinyRssReader
TRR.Views.Entries = class Entries extends Backbone.View
  el: '.entries_container'
  events:
    'click .fold_all': 'foldAll'
    'click .expand_all': 'unfoldAll'
    'click .mark_all_as_read': 'markAllAsRead'

  constructor: ->
    super
    @currentEntry = null
    @entries = for entry in @$('.entry')
      $entry = $(entry)
      view = new TRR.Views.Entry
        el: $entry
        model: new TRR.Models.Entry
          id: $entry.data('id')
          unread: $entry.hasClass('unread')
      @listenTo view, 'headclick', @toggleCurrentEntry
      view


  render: ->
    @$el.toggleClass('unread', @model.get('unread'))
    return @


  foldAll: ->
    for entry in @entries
      entry.fold()

  unfoldAll: ->
    for entry in @entries
      entry.unfold()

  markAllAsRead: ->
    if window.confirm('Are you sure?')
      for entry in @entries
        entry.markAsRead()


  toggleCurrentEntry: (entry) ->
    if @currentEntry?
      @currentEntry.unfocus()

    if @currentEntry == entry
      @currentEntry = null
    else
      @currentEntry = entry
      @currentEntry.focus()
      @currentEntry.markAsRead()
