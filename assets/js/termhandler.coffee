class TermHandler
  # TODO add arguments to control link back paths
  constructor: ->
    @usedTerms = []
    @emptyTerms()
    parent = this
    $("#area").change ->
      parent.resetField()
      parent.emptyTerms()

  isTermUsed: (term)->
    return $.inArray(term, @usedTerms) isnt -1

  addTerm: (term) ->
    if term isnt false
      @usedTerms.push term
      $("#selected_terms").append "<div class=\"selected_term\">" + term + "</div>"
  
  resetField: ->
    $("#term").val ""
    $(".ui-autocomplete").hide()
  
  emptyTerms: ->
    @usedTerms = []
    $("#selected_terms").html ""
    
  
  useTerm: (term) ->
    unless @isTermUsed(term)
      area = $("#area").val()
      parent = this
      $.ajax(
        url: "/useTerm"
        type: "POST"
        dataType: "json"
        data:
          area: area
          term: term
      ).done((data) ->
        parent.addTerm(data)
      ).complete(() ->
        parent.resetField()
      ).error ->
        console.log "The server is not responding"

$(document).ready ->

  autoTermHandler = new TermHandler

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
    autoTermHandler.useTerm term
