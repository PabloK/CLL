setMessage = (text) ->
  cover = $("#messageModal")
  cover.show()
  message = cover.children()
  message.html(text)
