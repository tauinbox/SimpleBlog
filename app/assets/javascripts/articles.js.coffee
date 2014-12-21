# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  $(".voteup").click (event) ->
    event.preventDefault()
    articleid = $(this).data "article-id"
    $.ajax
      url: '/articles/' + articleid + '/voteup'
      type: 'POST'
      error: (jqXHR, textStatus, errorThrown) ->
        console.log textStatus, errorThrown
      success: (result) ->
        res = "#votevalue"+articleid
        if result.vote
          val = $(res).text()
          $(res).text(parseInt(val) + 1)
        console.log result
        # alert res        
        # location.reload()
  $(".votedown").click (event) ->
    event.preventDefault()
    articleid = $(this).data "article-id"
    $.ajax
      url: '/articles/' + articleid + '/votedown'
      type: 'POST'
      error: (jqXHR, textStatus, errorThrown) ->
        console.log textStatus, errorThrown
      success: (result) ->
        res = "#votevalue"+articleid
        if result.vote
          val = $(res).text()
          $(res).text(parseInt(val) - 1)
        console.log result

$(document).ready(ready)
$(document).on('page:load', ready)