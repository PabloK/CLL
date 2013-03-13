setMessage = (text) ->
  cover = $("#messageModal")
  cover.show()
  cover.html(text)
  return cover
