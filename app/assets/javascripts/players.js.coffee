
ready = ->
  runplayermarketprocess()

$(document).ready(ready)
$(document).on('page:load', ready)
$(document).on('ajaxComplete', ready)

readynoajax = ->
  runplayermarketnoajax()

$(document).ready(readynoajax)
$(document).on('page:load', readynoajax)

runplayermarketnoajax = ->
  if $("title:contains('Player Market')").size() > 0
    $('#team').on 'click', '.add_fields', (event) ->
      time = new Date().getTime()
      regexp = new RegExp($(this).data('id'), 'g')
      $(this).before($(this).data('fields').replace(regexp, time))
      event.preventDefault()
    assemblecurrentteam()

runplayermarketprocess = ->
  if $("title:contains('Player Market')").size() > 0
    $('.playerdropdown').change ->
      $('#sortsubmit').click()

    jQuery("tbody .playerdetails").on('click', ->
      selectedplayer =
        id: $(this).attr('id').trim()
        surname: $(".surname",this).text().trim()
        club_shortname: $(".club_shortname",this).text().trim()
        price: $(".price",this).last().text().trim()
        position: $(".position",this).text().trim()
        squad: 'New'
        placement: null
      selectedplayer.placement = groundplacement(selectedplayer).trim()
      if selectedplayer.placement
        amount = parseFloat(selectedplayer.price) * -1
        teamtally(amount)
        addteammate(selectedplayer)
      )

    $("#footballground").undelegate().delegate('.cross', 'click', -> 
        price = $(this).parent().children('.pprice').text()
        selectedpos = $(this).parent().attr('id').trim()
        teamtally(price)
        $("#newplayers .placement[value= '" + selectedpos + "']").parent().remove()
        $(this).parent().removeClass('active').children().remove())

    teamvalue()
    insertpositionbuttons()
    arrangevisibility()
    $('#personel').on('click', validateform)
#    $('#flash_notice').delay(7000).slideUp('slow', 'swing')



assemblecurrentteam =->
  if $('#team_name').length > 0
    $('#teamname').html($('#team_name').val().italics())
  $('#hidepersonel>.newplayer').each (ind)->
    selectedplayer =
      id: $(this).children('.player_id').val().trim()
      placement: $(this).children('.placement').val().trim()
      price: $(this).children('.buy_price').val().trim()
      position:$(this).children('.position').val().trim()
      surname:$(this).children('.surname').val().trim()
      club_shortname: $(this).children('.club_shortname').val().trim()
      squad:'Original'
    groundplacement(selectedplayer)

teamvalue =->
  $('#teamtally').text("Cash : $" + $('#team_cash').val())

positionmarker = (obj, position) ->
  $(obj).parent().before("<tr><td class='"+position+"' colspan='5'>
    <button type='button' class='positionclass btn btn-info btn-xs col-lg-12 "+position+"'>"+position+"</button></td></tr>")
  $("." + position + ">button").click ->
    jQuery("#teamselect_id").val(position).change()

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
  x = 87 * shirtslide[selectedplayer.club_shortname].x
  y = 98 * shirtslide[selectedplayer.club_shortname].y
  if (selectedplayer.placement?)
    spot = $(".placeholder[id = " + selectedplayer.placement + "]")
  else
    spot = $(".placeholder[id ^=  " + selectedplayer.position + "]").not(".active").first()

  if $(spot).length
    $(spot).append("<div class='club_box'></div>")
    $(" .club_box" , spot).append("<div class='club_shirts'></div>")
    $(" .club_box .club_shirts", spot).prepend('<img src="/assets/clubshirts2.png" />')
    $(" .club_box .club_shirts", spot).css({left: "-"+x+"px", top: "-"+y+"px"})
    $(" .club_box", spot).after("<br><p class='playerblk makewhite pprice' style='margin-left:30px'>" + selectedplayer.price + "</p>")
    $(" .club_box", spot).after("<p class='playerblk makewhite' style='margin-left:7px'>" + selectedplayer.surname + "</p>")
    $(" .club_box", spot).after('<img class="playerblk cross" src="/assets/smallx.png" />')
    $(spot).addClass('active')
    spot.attr('id')
  else
    plypos = {}
    plypos.g = 'goalie'
    plypos.d = 'defender'
    plypos.m = 'midfielder'
    plypos.s = 'striker'
    $(".modal-body>blockquote>p").html("There are no valid " + 
      plypos[selectedplayer.position] + " spaces left for <em><strong>" +
      selectedplayer.surname + "</em></strong> .")
    $('#myDialogue').modal('show')
    false

addteammate=(newplayer)->
  $('.add_fields').click()
  $('#hidepersonel .player_id').last().val(newplayer.id)
  $('#hidepersonel .placement').last().val(newplayer.placement)
  $('#hidepersonel .buy_price').last().val(newplayer.price)
  $('#hidepersonel .bench').last()
    .val($('.newplayer .' + newplayer.placement + '.bench').val())

teamtally =(amount)->
  teamcash=  $('#team_cash').val()
  teamamount = (parseFloat(teamcash) + parseFloat(amount)).toFixed(2)
  $('#team_cash').val(teamamount)
  teamvalue()
  $('#teamtally').removeClass('label-info').addClass('label-danger') if teamamount < 0.00

validateform =() ->
  #check for tally, team number & unqiue players
  amount = $('#teamtally').text().match(/[\-\d\.]+/g)
  if parseFloat(amount) <= 0
    $(".modal-body>blockquote>p").html('Your team is over budget')
    $('#myDialogue').modal('show')
  else
    if $('.club_shirts').length < 15
      $(".modal-body>blockquote>p").html('Teams must have 15 players')
      $('#myDialogue').modal('show')    
    else
      playerids = []
      $('.player_id').each( (i, x) ->
        if $.inArray($(x).val(), playerids)  == -1
          playerids.push($(x).val())
      )
      if playerids.length < 15
        $(".modal-body>blockquote>p").html('You can only have unique players')
        $('#myDialogue').modal('show')
      else
        $('#personelsubmit').click()


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
  AVL:
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