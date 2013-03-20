setMessage = (text) ->
  cover = $("#messageModal")
  cover.show()
  cover.html(text)
  return cover

showFormattedMessage = (heading, body) ->
  url = "/message/" + heading + "/" + body
  $.ajax(
    url: url ,
    type: "GET" ,
    dataType: "html"
  ).done((data) ->
    setMessage(data).modal()
  ).error( ->
    console.log "The server is not responding"
  )
