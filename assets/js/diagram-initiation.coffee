sliderHeight = 15
initSlider = (initialCurrentValue = 0,initialTargetValue = sliderHeight) ->
  $(".targetAbility").vSlider({
    argMinHeight : ((self) ->
      return self.siblings(".currentAbility").height() + sliderHeight
    ),
    argMaxHeight : (() ->
      return $(".diagram-area").height() - sliderHeight
    ),
    initialValue :  initialTargetValue + sliderHeight
  })
  $(".currentAbility").vSlider({
    argMaxHeight : ((self) ->
      return self.siblings(".targetAbility").height() - sliderHeight
    ),
    initialValue :  initialCurrentValue
  })

# Helper function for calculating the values of the sliders
# TODO perhaps move this to the ability handler?
getSliderValues = () ->
  values = []
  $(".combination-diagram").each(()->
    maxHeight = $(this).parent().height()
    targetAbility = $(this).children(".targetAbility").height() - sliderHeight
    currentAbility = $(this).children(".currentAbility").height()
    name = $(this).children(".diagram-label").text()
    if maxHeight != 0
      targetAbilityPercent = 100 * (targetAbility / (maxHeight - sliderHeight*2))
    else
      targetAbilityPercent = 0
    if targetAbility != 0
      currentAbilityPercent = 100 * (currentAbility / (targetAbility))
    else
      currentAbilityPercent = 0
    values.push({name: name,target: targetAbilityPercent, current: currentAbilityPercent})
  )
  console.log(values)
  return values
$(document).ready(()->
  initSlider()
)

saveKey = () ->
  $.ajax(
    url: "/saveAbiliyKey"
    type: "POST"
    dataType: "json"
    data:
      abilities: getSliderValues(),
      name: $("#name").val()
  ).done((data) ->
    showFormattedMessage("Sparat", "Förmåge nyckeln har sparats")
  ).error( ->
    showFormattedMessage("Fel", "Det gick inte att spara nyckeln, pröva igen.")
  )
