window.onload = !->
  nav-items = document.get-elements-by-class-name 'navigator' .0.get-elements-by-tag-name 'li'
  pages = document.get-elements-by-class-name 'section'
  pages-num = pages.length

  resume-init!

  !function resume-init then
    init-navbar!
    init-pages!
    # init-scroll!


  !function init-navbar then
    nav-items.0.class-name += ' selected'
    _.for-each nav-items, (i)!-> i.onclick = navigate-to-click-index

  !function init-pages then
    document.get-elements-by-class-name 'section' .0 .class-name += ' current'
    init-skill-page!
    reset-pages!

  # TODO: using event lib to handle cb-list
  !function init-skill-page then
    skill-item-bar = document.get-elements-by-class-name 'item-bar'
    active-info = []
    _.for-each skill-item-bar, (item)!->
      item.onclick = (e)!->
        e.stop-propagation!
        info = @children.0
        if info and 0 > info.class-name.index-of 'display' then
          info.class-name += ' item-bar-info-display'
          active-info.push info
    skill-page = document.get-elements-by-class-name 'skill-section' .0
      ..onclick = (e)!->
        _.for-each active-info, (item)!->
          item.class-name = item.class-name.replace 'item-bar-info-display', ''
        # _.for-each skill-item-bar, (item)!->
        #   item.children.0?class-name.replace 'item-bar-info-display', ''

  !function reset-pages then
    _.for-each pages, (item, index)!->
      item.style.z-index = pages-num - index

  !function init-scroll then

    options = last-scroll: 0, scroll-limit: 500

    navigate-to-scroll-index = (e)->
      e.prevent-default!
      now = new Date!
      if now - options.last-scroll < options.scroll-limit then return false

      current = document.get-elements-by-class-name 'current' .0
      page-index = _.index-of current.parent-element.children, current
      current-scroll = e.original-event.wheel-delta
      if current-scroll < 0
         page-index < pages.length - 1 and navigate-to-index page-index + 1
      else if current-scroll > 0
        page-index > 0 and navigate-to-index page-index - 1
      options.last-scroll = now
      return false

    $ window .bind 'mousewheel', navigate-to-scroll-index


  !function navigate-to-index page-index then
    reset-pages!
    current = document.get-elements-by-class-name 'current' .0

    current-zindex = parse-int current.style.z-index
    # while --current-num > page-index
    #   pages[current-num]style.z-index = current-zindex
    if pages-num - page-index - 1 > current-zindex
      current.style.z-index = pages-num - page-index - 1

    _.for-each pages, (item, index)!->
      item.class-name = item.class-name.replace ' current', '' .replace ' page-before', '' .replace ' page-after', ''

      if index < page-index then item.class-name += ' page-before'
      else if index > page-index then item.class-name += ' page-after'
      else item.class-name += ' current'


    _.for-each nav-items, (item, index)!->
      item.class-name = item.class-name.replace ' selected', ''
      if index is page-index then item.class-name += ' selected'

  !function navigate-to-click-index e then
    page-index = _.index-of @parent-element.children, @
    navigate-to-index.call @, page-index


  function transition-end-event-name then
    e = document.create-element 'div'
    transitions =
      'transition': 'transitionend'
      'OTransition': 'otransitionend'
      'MozTransition': 'transitionend'
      'WebkitTransition': 'webkitTransitionEnd'

    for t of transitions
      if transitions.has-own-property t and e.style[t] isnt undefined
        return transitions[t]
    throw new Error 'TransitionEnd event is not supported in this browser!'

  # !function toggle-class e then
  #   target = $ e.target
  #   if target.has-class 'page-before-scale'
  #     target.remove-class 'page-before-scale'
  #     target.add-class 'page-before-translate'
  #   if target.has-class 'current-transition'
  #     target.remove-class 'current-transition'
  #     target.add-class 'current'



  # $ '.section' .on transition-end-event-name!, toggle-class
