class AbilityHandler
  constructor: ->
    @usedAbilitys = []
    @removeTimerOn = false
    parent = this
    $("#area").change ->
      parent.resetField()

  isAbilityUsed: (ability)->
    return $.inArray(ability, @usedAbilitys) isnt -1

  removeTimer: ->
    returnValue = @removeTimerOn
    @removeTimerOn = true
    abilityHandler = this
    setTimeout((-> abilityHandler.removeTimerOn = false),1000)
    return !returnValue

  # TODO handle colors and id's aswell
  addAbility: (ability) ->
    @usedAbilitys.push ability
    new_diagram = "
    <div class=\"combination-diagram\">
      <div class=\"diagram currentAbility cornflower\"></div>
      <div class=\"diagram targetAbility grey-6\"></div>
      <div class=\"remove-button label label-important\">
        <div class=\"icon-remove icon-white\"></div>
      </div>
      <label class=\"diagram-label\">" + ability + "</label>
    </div>
    "
    appended_diagram = $(".diagram-area").append(new_diagram)
   
    # Initiate a new slider 
    initSlider()
    abilityHandler = this
    
    $(".diagram-area").find(".remove-button").last().bind('vclick',()->
      if abilityHandler.removeTimer()
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
      ).done((response) ->
        if response["errors"].length > 0
          showFormattedMessage("Fel", response["errors"][0] )
        else
          parent.addAbility(response["ability"].name)
      ).complete(() ->
        parent.resetField()
      ).error ->
        console.log "The server is not responding"
    else
      showFormattedMessage("Fel", "Du har redan lagt till denna förmåga.")

$(document).ready ->
  
  autoAbilityHandler = new AbilityHandler

  $("#add_track").click((event)->
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
    if typeof (ui) isnt "undefined"
      ability = ui.item.value.toLowerCase()
    else
      ability = $("#ability")[0].value.toLowerCase()
    autoAbilityHandler.useAbility ability
