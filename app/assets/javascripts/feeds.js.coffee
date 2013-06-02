$ ->
  entriesView = window.main = new TinyRssReader.Views.Entries()
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
      entry = entriesView.currentEntry
      if entry?
        entry.model.toggleUnread()
  }
