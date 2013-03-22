# jQuery Plugin for creating a vertical slider diagram
# Version: alpha 1.0
# Author: Pablo Karlsson
# Git-Hub: https://github.com/PabloK
# Dependancies: Jquery, Jquerymobile
(($) ->
  $.fn.vSlider = (arg={}) ->

    # Standard configuration
    container = $(".diagram-area")
    initialValue = 0
    argMinHeight = undefined
    argMaxHeight = undefined

    # Mobile version
    $(document).bind('vmouseup',()->
      container.unbind('vmousemove')
    )
    
    # Customization of configuration 
    if arg.hasOwnProperty("container")
      container = $(arg["container"])
    if arg.hasOwnProperty("argMinHeight")
      argMinHeight = arg["argMinHeight"]
    if arg.hasOwnProperty("argMaxHeight")
      argMaxHeight = arg["argMaxHeight"]
    if arg.hasOwnProperty("initialValue")
      initialValue = arg["initialValue"]
    
    # Create new elements for each slider & bind events to them
    this.each(()->
      # Creating new element
      diagram = $(this)
      unless diagram.children().hasClass("vslider")
        diagram.height(initialValue)
        vSliderHtml = '<div class="vslider"></div>'
        vSlider = $(vSliderHtml).appendTo(diagram)
        
        # Equipping the diagram with callable methods
        diagram.resize = (change, maxHeight, minHeight) ->
          # Default configure heights
          unless maxHeight
            maxHeight = container.height()
          unless minHeight
            minHeight = 0

          # heights can be functions or value
          if minHeight instanceof Function
            minHeight = minHeight(diagram)
          else
            minHeight = minHeight

          if maxHeight instanceof Function
            maxHeight = maxHeight(diagram)
          else
            maxHeight = maxHeight
          
          # Calculate the new height
          newHeight = diagram.height() + change

          # Keep the hieght with in bounds
          unless newHeight < maxHeight
            newHeight = maxHeight
          unless newHeight > minHeight
            newHeight = minHeight

          diagram.height(newHeight)

        vSlider.bind('vmousedown',(event)->
          # Set starting position of mouse 
          startPosition = event.pageY
          container.bind('vmousemove',(event)->
            deltaY = startPosition - event.pageY
            unless deltaY == 0
              startPosition = event.pageY
              diagram.resize(deltaY,argMaxHeight,argMinHeight)
              # TODO perhaps update hidden form field
          )
        )
    )
    return this
  
  # Helper for removing the sliders
  $.fn.vSlider.remove = () ->
    return $(".vslider").remove()
) jQuery
