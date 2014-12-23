# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  $(".voteupp").click (event) ->
    event.preventDefault()
    userid = $(this).data "user-id"
    $.ajax
      url: '/users/' + userid + '/profile/voteup'
      type: 'POST'
      error: (jqXHR, textStatus, errorThrown) ->
        console.log textStatus, errorThrown
      success: (result) ->
        res = "#votevalue"+userid
        if result.vote
          val = $(res).text()
          $(res).text(parseInt(val) + 1)
        console.log result
        # alert res        
        # location.reload()
  $(".votedownp").click (event) ->
    event.preventDefault()
    userid = $(this).data "user-id"
    $.ajax
      url: '/users/' + userid + '/profile/votedown'
      type: 'POST'
      error: (jqXHR, textStatus, errorThrown) ->
        console.log textStatus, errorThrown
      success: (result) ->
        res = "#votevalue"+userid
        if result.vote
          val = $(res).text()
          $(res).text(parseInt(val) - 1)
        console.log result

$(document).ready(ready)
$(document).on('page:load', ready)