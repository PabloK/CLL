addTerm = (term) ->
  $("#selected_terms").append "<div class=\"selected_term\">" + term + "</div>"

resetField = ->
  $("#term").val ""
  $(".ui-autocomplete").hide()

emptyTerms = ->
  $("#selected_terms").html ""

useTerm = (term) ->
  area = $("#area").val()
  console.log area
  $.ajax(
    url: "/useTerm"
    type: "POST"
    dataType: "json"
    data:
      area: area
      term: term
  ).done((data) ->
    if data isnt false
      addTerm data
      usedTerms.push data
  ).complete(->
    resetField()
  ).error ->
    console.log "error"

$(document).ready ->
  $("#cover").show()

usedTerms = []
$(document).ready ->
  $("#area").change ->
    emptyTerms()

  auto = $("#term").autocomplete(
    source: (request, response) ->
      $.ajax(
        url: "/findTerm"
        type: "POST"
        dataType: "json"
        data:
          area: $("#area").val()
          term: request.term
      ).done (data) ->
        response data

    messages:
      noResults: ""
      results: ->
    )

  auto.on "autocompleteselect", (event, ui) ->
    if typeof (ui) isnt "undefined"
      term = ui.item.value.toLowerCase()
    else
      term = $("#term")[0].value.toLowerCase()
    useTerm term  if $.inArray(term, usedTerms) is -1
