setMessage = (text) ->
  cover = $("#cover")
  cover.show()
  message = cover.children()
  message.html(text)

popup = (configure) ->
  cover = $("#cover")
  message = cover.children()
  if configure["url"] != undefined
    $.get(configure["url"]).success((setMessage)).error(setMessage(""))
    
  if configure["text"] != undefined
    setMessage(configure["text"])

closeMessage = ()->
  $("#cover").hide()
  return false

$(document).ready((->
  $(document).keydown((
    (e)->
      code = e.keyCode
      if code == 27
        closeMessage()
  ))))
