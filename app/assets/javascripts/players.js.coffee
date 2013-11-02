# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
	jQuery(".shortname").animate({"color":"red"},1000)

ready = ->
    jQuery('#playersort').change ->    	
    	alert('happed')

    prev = 'x'
    jQuery('tbody .position').each((ind, elem)->
      curr = jQuery.trim($(elem).text())
      if curr isnt prev
    	   switch curr
            when "m"
              positionmarker(elem, "Midfield")
            when "g" 
              positionmarker(elem, "Goalie")
            when "d" 
              positionmarker(elem, "Defender")
            else
              positionmarker(elem, "Striker")

      prev = curr
    )



$(document).ready(ready)
$(document).on('page:load', ready)

positionmarker = (obj, position) ->
#  alert 'in positinmarker' + position
#  alert $(obj).get(0).tagName
#  alert ' parent' + $(obj).parent().attr('id')
#  alert ' parent brother' + $(obj).parent().prev().attr('id')
  $(obj).parent().before("<tr><td class='"+position+"' colspan='5'>
    <button type='button' class='btn btn-info col-md-12'>"+position+"
    </button></td></tr>")

