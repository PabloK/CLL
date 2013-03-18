class AbilityHandler
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
      # TODO this could perhaps be a view
      new_diagram = "
      <div class=\"combination-diagram\">
        <div class=\"diagram currentAbility cornflower\"></div>
        <div class=\"diagram targetAbility grey-5\"></div>
        <div class=\"remove-button label label-important\">
          <div class=\"icon-remove icon-white\"></div>
        </div>
        <label class=\"diagram-label\">" + ability + "</label>
      </div>
      "
      $(".diagram-baseline").append(new_diagram)
     
      # Initiate a new slider 
      initSlider()
      abilityHandler = this
      $(".remove-button").click(()->
        abilityHandler.removeAbility(ability)
        $(this).parent().remove()
      )

  removeAbility: (ability) ->
    index = $.inArray(ability, @usedAbilitys)
    unless index == -1
      @usedAbilitys.splice(index,1)
  
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
  $("#add_track").click(()->
      track = $("#track").val()
      $.ajax(
        url: "/abilitiesForTrack"
        type: "POST"
        dataType: "json"
        data:
          track: track
      ).done((data) ->
        console.log(data)
        # TODO handle the ability array
        #autoAbilityHandler.addAbility(data)
      ).error( ->
        console.log "The server is not responding"
      )
  )
  auto = $("#ability").autocomplete(
    source: (request, response) ->
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
