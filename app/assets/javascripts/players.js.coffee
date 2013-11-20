# stuff

ready = ->
    jQuery('#sortsubmit').hide()
    jQuery('.playerdropdown').change ->
        jQuery('#sortsubmit').click()

    jQuery("tbody .playerdetails").on('click', ->
        selectedplayer =
          id: $(this).attr('id').trim()
          surname: $(".surname",this).text().trim()
          club_shortname: $(".club_shortname",this).text().trim()
          position: $(".position",this).text().trim()
        groundplacement(selectedplayer))

    $("#footballground").delegate('.cross', 'click', -> 
        $(this).parent().removeClass('active').children().remove())

    insertpositionbuttons()
    arrangevisibility()

$(document).ready(ready)
$(document).on('page:load', ready)
$(document).on('ajaxComplete', ready)

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
            when "s"
              positionmarker(elem, "Strikers")

        prev = curr
      )

groundplacement =(selectedplayer)->
  x = 100 * shirtslide[selectedplayer.club_shortname].x
  y = 110 * shirtslide[selectedplayer.club_shortname].y
#  $("#g1 div").remove()
  spot = $(".placeholder[id ^=  " + selectedplayer.position + "]").not(".active").first()
  if $(spot).length
    $(spot).append("<div class='club_box'></div>")
    $(" .club_box" , spot).append("<div class='club_shirts'></div>")
    $(" .club_box .club_shirts", spot).prepend('<img src="/assets/clubshirts.png" />')
    $(" .club_box .club_shirts", spot).css({left: "-"+x+"px", top: "-"+y+"px"})
    $(" .club_box", spot).after("<h4 class='playerblk makewhite'>" + selectedplayer.surname + "</h4>")
    $(" .club_box", spot).after('<img class="playerblk cross" src="/assets/smallx.png" />')
    $(spot).addClass('active')
  else
    alert('No valid spaces left')

shirtslide =
  ARS:
    x:0
    y:0
  CAR:
    x:1
    y:0
  LIV:
    x:2
    y:0
  SWA:
    x:3
    y:0
  STH:
    x:4
    y:0
  STK:
    x:0
    y:1
  FUL:
    x:1
    y:1
  MCI:
    x:2
    y:1
  HUL:
    x:3
    y:1
  NEW:
    x:4
    y:1
  EVE:
    x:0
    y:2
  TOT:
    x:1
    y:2
  CHE:
    x:2
    y:2
  WBA:
    x:3
    y:2
  WHM:
    x:4
    y:2
  MU:
    x:0
    y:3
  AST:
    x:1
    y:3
  NOR:
    x:2
    y:3
  SUN:
    x:3
    y:3
  CPA:
    x:4
    y:3