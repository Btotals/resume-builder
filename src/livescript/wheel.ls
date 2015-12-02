# ((window, document)!->
#   var support
#   # detect event model whether is non-IE or IE
#   if window.add-event-listener
#     _add-event-listener = "addEventListener"
#     prefix = "on"
#   else
#     _add-event-listener = "attachEvent"

#   # detect available wheel event
#   if document.onmousewheel isnt undefined then support = "mousewheel"
#   try
#     WheelEvent 'wheel'
#     support = 'wheel'
#   catch e
#   if !support then support = "DOMMouseScroll"

#   window.add-wheel-listener = (elem, callback, usr-capture)!->
#     _add-wheel-listener elem, support, callback, usr-capture
#     if support is "DOMMouseScroll"
#       _add-wheel-listener elem, "MozMousePixelScroll", callback, usr-capture

#   wheel-handler = (origin-event)!->
#     !origin-event and (origin-event = window.event)
#     event =
#       origin-event: origin-event
#       target: origin-event.target || origin-event.src-element
#       type: 'wheel'
#       delta-mode: if origin-event.type is 'MozMousePixelScroll' then 0 else 1
#       delta-x: 0
#       delta-z: 0
#       prevent-default: !->
#         if origin-event.prevent-default then origin-event.prevent-default!
#         else origin-event.return-value = false
#     if support is 'mousewheel' then event.delta-y = -1/40 * origin-event.wheel-delta-x
#     else event.delta-y = origin-event.detail
#     callback event

#   function _add-wheel-listener elem, event-name, callback, usr-capture then
#     elem[_add-event-listener] prefix+event-name, if support is "wheel" then callback else wheel-handler, usr-capture || false
# )(window, document)

# $ document .bind 'mousewheel', (e)!-> console.log 'hehe'
