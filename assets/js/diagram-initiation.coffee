sliderHeight = 10
initSlider = () ->
  $(".targetAbility").vSlider({
    argMinHeight : ((self) ->
      return self.siblings(".currentAbility").height() + sliderHeight
    ),
    argMaxHeight : (() ->
      return $(".diagram-baseline").height() - sliderHeight
    ),
    initialValue :  sliderHeight
  })
  $(".currentAbility").vSlider({
    argMaxHeight : ((self) ->
      return self.siblings(".targetAbility").height() - sliderHeight
    )
  })

# Helper function for calculating the values of the sliders
getSliderValues = () ->
  $(".combination-diagram").each(()->
    maxHeight = $(this).parent().height()
    targetAbility = $(this).children(".targetAbility").height() - sliderHeight
    currentAbility = $(this).children(".currentAbility").height()
    if maxHeight != 0
      targetAbilityPercent = 100 * (targetAbility / (maxHeight - sliderHeight*2))
    else
      targetAbilityPercent = 0
    if targetAbility != 0
      currentAbilityPercent = 100 * (currentAbility / (targetAbility))
    else
      currentAbilityPercent = 0
    console.log([targetAbilityPercent, currentAbilityPercent])

  )

$(document).ready(()->
  initSlider()
)
