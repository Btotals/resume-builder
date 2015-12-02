$ resume-init

!function resume-init then
  init-navbar!
  init-pages!
  init-scroll!


!function init-navbar then
  nav-bar = $ '.navigator'
  nav-items = nav-bar.find 'li'
  nav-items.click navigate-to-click-index

!function init-pages then
  $ '.section' .eq 0 .add-class 'current'
  pages = $ '.pages' .children!length
  $ '.section' .to-array!for-each (item, index)!->
    $ item .css 'z-index': pages - index

!function init-scroll then
  pages = $ '.pages' .children!length
  navigate-to-scroll-index = (e)->
    e.prevent-default!
    page-index = $ '.current' .index!
    current-scroll = e.original-event.wheel-delta
    if current-scroll < 0
       page-index < pages and navigate-to-index page-index + 1
    else if current-scroll > 0
      page-index > 0 and navigate-to-index page-index - 1
    return false;
  $ window .bind 'mousewheel', _.throttle(navigate-to-scroll-index, 1200)


!function navigate-to-index page-index then
  pages = $ '.pages' .children!length
  $ '.section' .remove-class 'current page-before page-after'
  $ '.section' .to-array!for-each (item, index)!->
    if index < page-index then $ item .add-class 'page-before'
    else if index > page-index then $ item .add-class 'page-after'
    else $ item .add-class 'current'
  nav-icons = $ '.navigator .item'
    ..remove-class 'selected'
    ..eq page-index .add-class 'selected'

!function navigate-to-click-index e then
  page-index = $ @ .index!
  navigate-to-index.call @, page-index

# !function navigate-to-scroll-index e then

