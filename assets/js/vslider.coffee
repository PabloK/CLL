# jQuery plugin wrapper
(($) ->
  $.fn.vSlider = (arg) ->
    #Configuration
    #unless arg.hasOwnProperty("option")
    #  arg["option"] = "default"
    
    # Handle the list of elements
    this.each(()->
      vSliderHtml = '<div class="vslider"></div>'
      vSlider = $(vSliderHtml).appendTo(this)
      vSlider.mouseup(()-> #stopresize
      )
      vSlider.mousedown(()-> #startresize
      )
    )
    return this
     
) jQuery
