class AbilityHandler
  constructor: ->
    @usedAbilitys = []
    parent = this
    $("#area").change ->
      parent.resetField()

  isAbilityUsed: (ability)->
    return $.inArray(ability, @usedAbilitys) isnt -1

  # TODO handle colors and id's aswell
  addAbility: (ability) ->
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
    appended_diagram = $(".diagram-baseline").append(new_diagram)
   
    # Initiate a new slider 
    initSlider()
    abilityHandler = this
    $(".diagram-baseline").find(".remove-button").last().click(()->
      abilityHandler.removeAbility(ability)
      $(this).parent().remove()
    )

  removeAbility: (ability) ->
    console.log(@usedAbilitys)
    index = $.inArray(ability, @usedAbilitys)
    unless index == -1
      @usedAbilitys.splice(index,1)
    console.log(@usedAbilitys)
  
  resetField: ->
    $("#ability").val ""
    $(".ui-autocomplete").hide()
  
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
      ).done((ability) ->
        if ability isnt false
          parent.addAbility(ability.name)
      ).complete(() ->
        parent.resetField()
      ).error ->
        console.log "The server is not responding"

$(document).ready ->
  
  autoAbilityHandler = new AbilityHandler

  $("#add_track").click((event)->
    console.log(event)
    track = $("#track").val()
    $.ajax(
      url: "/abilitiesForTrack"
      type: "POST"
      dataType: "json"
      data:
        track: track
    ).done((data) ->
      for ability in data
        unless autoAbilityHandler.isAbilityUsed(ability.name)
          autoAbilityHandler.addAbility(ability.name)
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
    event.preventDefault
    if typeof (ui) isnt "undefined"
      ability = ui.item.value.toLowerCase()
    else
      ability = $("#ability")[0].value.toLowerCase()
    autoAbilityHandler.useAbility ability
