focus = (el) -> $(el)
  .addClass('current')
  .removeClass('folded')

unfocus = (el) -> $(el)
  .removeClass('current')
  .addClass('folded')

changeFocusTo = (el) ->
  unfocus $('.current')
  focus el

$ ->

  $('.entry').addClass 'folded'



  # Events
  # ------

  $('.fold_all').on 'click', -> $('.entry').addClass('folded')
  $('.expand_all').on 'click', -> $('.entry').removeClass('folded')

  $('.entries').on 'click', '.entry .head', ->
    $entry = $(@).parent()

    if $entry.hasClass 'current'
      unfocus $entry
    else
      changeFocusTo $entry

  $('.mark_all_as_read').on 'click', ->
    if window.confirm('Are you sure?')
      alert('mijissou')


  # Keybindings
  # -----------

  _changeFocus = ($current, $target) ->
    if $target[0]?
      changeFocusTo $target
    else if !$current[0]?
      changeFocusTo $('.entry:first')

    window.scrollTo(null, $('.current').position().top)

  Mousetrap.bind 'j', ->
    _changeFocus(
      $('.current')
      $('.current').next()
    )

  Mousetrap.bind 'k', ->
    _changeFocus(
      $('.current')
      $('.current').prev()
    )
