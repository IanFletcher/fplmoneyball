# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  runsquadprocess()
  $('#flash_notice').delay(5000).slideUp('slow', 'swing')

$(document).ready(ready)
$(document).on('page:load', ready)
$(document).on('ajaxComplete', ready)

runsquadprocess = ->
  if $("title:contains('Squad')").size() > 0
    assembleteam()
    applytransfer()
    $('#firstteamsubmit').on('click', validateform)
#    $('#flash_notice').delay(7000).slideUp('slow', 'swing')

validateform = ->
    $('#squadsubmit').click()


applytransfer = ->
  $("#footballground").undelegate()
  $('#reservebench').undelegate()  
  $("#footballground").delegate('.glyphicon-transfer', 'click', ->
    if $('.glyphicon-hand-right').size() == 0
      $(this).removeClass('glyphicon-transfer')
        .addClass('glyphicon-hand-right')
      changereserve())
  $("#footballground").delegate('.glyphicon-hand-right', 'click', ->
    $(this).removeClass('glyphicon-hand-right')
      .addClass('glyphicon-transfer'))
  $('#reservebench').delegate('.glyphicon-transfer', 'click', ->
    if $('.glyphicon-hand-left').size() == 0
      $(this).removeClass('glyphicon-transfer')
        .addClass('glyphicon-hand-left')
      changereserve())
  $('#reservebench').delegate('.glyphicon-hand-left', 'click', ->
    $(this).removeClass('glyphicon-hand-left')
      .addClass('glyphicon-transfer'))

changereserve = ->
  #find hand icons and exchange 
  if $('.glyphicon-hand-right').size() == $('.glyphicon-hand-left').size()
    goingtoreserves = $('.glyphicon-hand-right').parent()
    outofreserves = $('.glyphicon-hand-left').parent()
    playeroff = footballgroundplayerid(goingtoreserves)
    playeron = footballgroundplayerid(outofreserves)
    posmap = false
    if posmap = formationrules(playeroff, playeron)
      $(goingtoreserves).children('.glyphicon-hand-right')
        .removeClass('glyphicon-hand-right').addClass('glyphicon-transfer')
      $('div:hidden').children("." + playeron.classname).parent().show()
      $(".player_id[value= '" + playeron.id + "']").siblings('.bench')
        .val('')
      $(outofreserves).addClass('.vacant').empty()
      $(".player_id[value= '" + playeroff.id + "']")
        .siblings('.bench').val($(outofreserves).attr('id'))
      $(outofreserves).html($(goingtoreserves).html())
        .removeClass('.vacant')
      $(goingtoreserves).hide()
      posmap.adjustfootballground()
    else
      $("#myDialogueLabel").text('Team Formation Error')
      $(".modal-body>blockquote>p").html('Wrong formation, you can only have 1 goalie, 3 to 5 defenders, 3 to 5 midfielders & 1 to 3 strikers.')
      $('#myDialogue').modal('show')

formationrules = (playeroff, playeron) ->
  mp = new PositionMap
  mp.remove(playeroff.position)
  mp.add(playeron.position)
  mp.rules()

class PositionMap
  constructor: ->
    @currentpositions = []
    onfield = $(".newplayer").filter(-> 
      $(this).children('.bench').val() == "")
    @currentpositions = $(onfield).map( -> 
      $(this).children('.position').val()).get()
  positions: ->
    @currentpositions
  remove: (position) ->
    @currentpositions
      .splice(@currentpositions.indexOf(position), 1)
  add: (position) ->
    @currentpositions.push(position)
  rules: ->
    @playerformation()
    if @counts.g == 1 and @counts.d >= 3 and @counts.m >= 3 and @counts.s >= 1 and @counts.g? and @counts.d? and @counts.m? and @counts.s?
      #give positionmap back
      this
    else
      false
  playerformation: ->
    @counts = {}
    for position in @currentpositions
       if @counts[position] 
         @counts[position]++
       else 
         @counts[position] = 1
  adjustfootballground: ->
    @playerformation()
    #6 - counts
    @fixoffset(positionletter, count) for positionletter, count of @counts
  fixoffset: (posletter, totalcolumns) ->
    maxoffset = 6
    pospadding = posletter + "padding"
    columnoffset = maxoffset - totalcolumns
    classpadding = "col-md-" + columnoffset.toString() + " col-sm-" + 
      columnoffset.toString()
    $("#" + pospadding).removeClass($("#" + pospadding).attr('class'))
      .addClass(classpadding)

footballgroundplayerid = (squadplayer) ->
  player = {}
  player.id = $(squadplayer).children('.club_box').attr('class')
    .split(' ')[1].replace( /^\D+/g, '')
  player.position = $(".player_id[value= '" + player.id + "']")
    .siblings('.position').val()
  player.classname = $(squadplayer).children('.club_box').attr('class')
    .split(' ')[1] 
  player

assembleteam = ->
  fullsquad = []
  i = 0
  $('.newplayer').each (ind)->
    selectedplayer =
      id: $(this).children('.player_id').val().trim()
      placement: $(this).children('.placement').val().trim()
      price: $(this).children('.buy_price').val().trim()
      position:$(this).children('.position').val().trim()
      surname:$(this).children('.surname').val().trim()
      club_shortname: $(this).children('.club_shortname').val().trim()
      bench: $(this).children('.bench').val().trim()
    fullsquad[i++] =selectedplayer
    squadformation(selectedplayer)
  postreservebench()

squadformation = (selectedplayer)->
  x = 87 * window.Global.shirtslide[selectedplayer.club_shortname].x
  y = 98 * window.Global.shirtslide[selectedplayer.club_shortname].y
  spot = $("#" + selectedplayer.placement)
  $(spot).append("<div class='club_box'></div>")
  $('.club_box', spot).addClass("plyid"+selectedplayer.id)
  $(spot).children(".club_box").append("<div class='club_shirts'></div>")
  $(spot).children(".club_box").children(".club_shirts").append('<img src="/assets/clubshirts2.png" />')
  $(spot).children(".club_box").children(".club_shirts").css({left: "-"+x+"px", top: "-"+y+"px"})
  $(" .club_box", spot).after("<p class='playerblk makewhite' style='margin-left:7px'>" + selectedplayer.surname + "</p>")
  $(" .club_box", spot).after("<div class='makewhite playerblk glyphicon glyphicon-transfer'></div>")

    
  
postreservebench = ->
  bench = $('.newplayer>.bench').filter( -> $(this).val())
  if $(bench).length == 0
    defaultbench() 
  else
    $(bench).siblings('.placement').each( ->
      makereserve($(this).val()))
  mp = new PositionMap
  mp.adjustfootballground()

defaultbench = ->
  # take last goalie,defender,midfielder, striker
  makereserve('g2')
  makereserve('s3')
  makereserve('m5')
  makereserve('d5')

makereserve = (res) ->
  if res.search('g') == 0
    reserveseat = $('#reservegoalie.vacant')
  else
    reserveseat = $("[id*='reserve'].vacant").filter( ->
      g = $(this).attr('id').match(/\d/)).first()

  $(reserveseat).html($('#' + res).html()).removeClass('vacant')
  player_id = $('#' + res).children('.club_box').attr('class')
    .split(' ')[1].replace( /^\D+/g, '')
  #update bench with reserve status
  $(".player_id[value='" + player_id + "']").siblings(".bench")
    .val($(reserveseat).attr('id'))
  $('#' + res).hide()