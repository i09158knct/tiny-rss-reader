TRR = window.TinyRssReader
TRR.Views.Entries = class Entries extends Backbone.View
  el: '.entries_container'
  events:
    'click .fold_all': 'foldAll'
    'click .expand_all': 'unfoldAll'
    'click .mark_all_as_read': 'markAllAsRead'

  constructor: (opts={}) ->
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

    if !opts.nosy? || opts.nosy
      nosyProcess(@)


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



nosyProcess = (entriesView) ->
  entriesView.foldAll()
  entriesView.$('a').prop('target', '_blank')


  # Keybindings
  # -----------

  _changeTo = (offset) ->
    currentIndex = entriesView.entries.indexOf entriesView.currentEntry
    targetIndex = currentIndex + offset

    nextTarget =
      if currentIndex < 0
        entriesView.entries[0]
      else if currentIndex >= 0 &&
              targetIndex >= 0 &&
              targetIndex < entriesView.entries.length
        entriesView.entries[targetIndex]

    if nextTarget?
      entriesView.toggleCurrentEntry nextTarget


  Mousetrap.bind key, cb for key, cb of {
    'j': ->
      _changeTo(+1)
      window.scrollTo(null, $('.current').position().top)

    'k': ->
      _changeTo(-1)
      window.scrollTo(null, $('.current').position().top)

    'm': ->
      entriesView.currentEntry?.model.toggleUnread()
  }
