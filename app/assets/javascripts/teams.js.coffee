# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


ready = ->

$(document).ready(ready)
$(document).on('page:load', ready)
$(document).on('ajaxComplete', ready)

readynoajax = -> 
  runbalancesheetnoajax()

$(document).ready(readynoajax)
$(document).on('page:load', readynoajax)

runbalancesheetnoajax = ->
  @gwcarousel = new Carousel

class Carousel
  constructor: ->
    @x = 0
    @speed= 1000
    @inc = 120
    @left = "left"
    @right = "right"
    @slides = $('.weekbox').size() * -1
    @currentx = 0
    @attachbuttons()
    @startinglocation()
  startinglocation: ()->
    slides = @slides * -1
    self = this
    $('.weekbox button').each( (index, element)->
      if $(element).attr('class').match(/activegw/)
        if index < 3 
          x = 0
        else
          if slides > index then x = index - 4 else x = slides - 3
        self.currentx = x
        self.step(x)
    )
  attachbuttons: ->
    selfinstance = this
    $("#gameweeksgrid").on('click', ".arrowbox", (event) ->
      move = $(this).attr('class').split(' ')[1].trim()
      selfinstance.speed = 500
      selfinstance.direction(move)
      )
    $("#gameweeksgrid").on('dblclick', ".arrowbox", (event) ->
      move = $(this).attr('class').split(' ')[1].trim()
      selfinstance.speed = 250
      selfinstance.direction(move)
      selfinstance.direction(move)
      )  
    $("#gameweeksgrid").on('click', "#gwbutton", (event) ->
      selfinstance.reset()
    )

  reset: ->
    @step(@currentx)
  direction: (move) ->
    x = @x
    if @left == move 
      if 0 >= (x + 1) then x += 1
    else
      if @slides + 4 <= (x - 1) then x -= 1
    @step(x)
  step: (x) ->
    if @x != x
      @x = x
      xpos = @x * @inc
      $("#weekboxes").animate({left:xpos}, @speed, "linear")

