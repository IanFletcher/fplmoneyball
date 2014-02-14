# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


ready = ->
  runbalancesheet()

$(document).ready(ready)
$(document).on('page:load', ready)
$(document).on('ajaxComplete', ready)

runbalancesheet = ->
  

carousel = (direction)->
	
class Carousel
  constructor: ->
    @x = 0
    @inc = 154
    @left = "left"
    @right = "right"
    # @maxx = count gameweeks
  reset: ->
    step(0)
  direction: (move) ->
    x = @x
    if @right == move 
      if maxx >= (x + 1) then x += 1
    else
      if 0 <= (x + 1) then x -= 1
    step(x)
  step: (x) ->
    if @x != x
      @x = x
      xpos = @x * @inc
      $("#weekboxes").animate({left:xpos}, 1000, "swing")
    end

@gwcarousel = new Carousel