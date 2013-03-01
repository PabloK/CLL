initiateAbilityKey = () ->
  $(".targetAbility").vSlider({
    argMinHeight : ((self) ->
      return self.siblings(".currentAbility").height() + 10
    ),
    argMaxHeight : (() ->
      return $(".diagram-baseline").height() - 10
    ),
    initialValue :  10
  })
  $(".currentAbility").vSlider({
    argMaxHeight : ((self) ->
      return self.siblings(".targetAbility").height() - 10
    )
  })
$(document).ready(()->
  initiateAbilityKey()
)
