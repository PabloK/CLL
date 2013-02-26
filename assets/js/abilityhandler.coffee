# encoding: utf-8
class AbilityHandler
  # TODO add arguments to control link back paths
  constructor: ->
    @usedAbilitys = []
    @emptyAbilitys()
    parent = this
    $("#area").change ->
      parent.resetField()
      parent.emptyAbilitys()

  isAbilityUsed: (ability)->
    return $.inArray(ability, @usedAbilitys) isnt -1

  addAbility: (ability) ->
    if ability isnt false
      @usedAbilitys.push ability
      $("#selected_abilitys").append "<div class=\"selected_ability\">" + ability + "</div>"
  
  resetField: ->
    $("#ability").val ""
    $(".ui-autocomplete").hide()
  
  emptyAbilitys: ->
    @usedAbilitys = []
    $("#selected_abilitys").html ""
    
  
  useAbility: (ability) ->
    unless @isAbilityUsed(ability)
      area = $("#area").val()
      parent = this
      $.ajax(
        url: "/useAbility"
        type: "POST"
        dataType: "json"
        data:
          area: area
          ability: ability
      ).done((data) ->
        parent.addAbility(data)
      ).complete(() ->
        parent.resetField()
      ).error ->
        console.log "The server is not responding"

$(document).ready ->

  autoAbilityHandler = new AbilityHandler

  auto = $("#ability").autocomplete(
    source: (request, response) ->
      
      console.log(request)
      $.ajax(
        url: "/findAbility"
        type: "POST"
        dataType: "json"
        data:
          area: $("#area").val()
          ability: request.term
      ).done (data) ->
        response data

    messages:
      noResults: ""
      results: ->
    )

  auto.on "autocompleteselect", (event, ui) ->
    if typeof (ui) isnt "undefined"
      ability = ui.item.value.toLowerCase()
    else
      ability = $("#ability")[0].value.toLowerCase()
    autoAbilityHandler.useAbility ability
