# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
#    jQuery('#playersort_id').change ->
#      $('#sortsubmit').click() 
 #     thesort =$(this).val()
 #     sort_url = jQuery('.playercontainer').data('url')
 #     alert(sort_url)  
 #     jQuery.ajax(
 #        url: sort_url
 #        type: 'get'
 #        data: sort: thesort
 #        datatype: 'script'
 #     )
 #     link_to sort_path(sort: thesort)

    jQuery('#sortsubmit').hide()
    jQuery('.playerdropdown').change ->
        jQuery('#sortsubmit').click()

    insertpositionbuttons()
    arrangevisibility()



$(document).ready(ready)
$(document).on('page:load', ready)

positionmarker = (obj, position) ->
  $(obj).parent().before("<tr><td class='"+position+"' colspan='5'>
    <button type='button' class='btn btn-info col-md-12 "+position+"'>"+position+"</button></td></tr>")
  $("." + position + ">button").click ->
    jQuery("#team_id").val(position).change()


arrangevisibility =->
   jQuery(".optional").hide()
   visclass = jQuery('#playersort_id :selected').val()
   jQuery("." + visclass + ".optional").show() 


insertpositionbuttons =->
    arr = ['Goalies','Defenders','Midfielders','Strikers']
    posselect = jQuery('#team_id :selected').val()
    if !(jQuery.inArray(posselect, arr) >=0)
      prev = 'x'
      jQuery('tbody .position').each((ind, elem)->
        curr = jQuery.trim($(elem).text())
        if curr isnt prev
          switch curr
            when "m"
              positionmarker(elem, "Midfielders")
            when "g" 
              positionmarker(elem, "Goalies")
            when "d" 
              positionmarker(elem, "Defenders")
            else
              positionmarker(elem, "Strikers")

        prev = curr
      )
