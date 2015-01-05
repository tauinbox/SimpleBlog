# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  $(".voteupc").click (event) ->
    event.preventDefault()
    commentid = $(this).data "comment-id"
    articleid = $(this).data "article-id"
    $(this).parent().hide("slow")
    $.ajax
      url: '/articles/' + articleid + '/comments/' + commentid + '/voteup'
      type: 'POST'
      error: (jqXHR, textStatus, errorThrown) ->
        console.log textStatus, errorThrown
      success: (result) ->
        res = "#votevalue"+commentid
        if result.vote
          val = $(res).text()
          $(res).text(parseInt(val) + 1)
        console.log result

  $(".votedownc").click (event) ->
    event.preventDefault()
    commentid = $(this).data "comment-id"
    articleid = $(this).data "article-id"
    $(this).parent().hide("slow")
    $.ajax
      url: '/articles/' + articleid + '/comments/' + commentid + '/votedown'
      type: 'POST'
      error: (jqXHR, textStatus, errorThrown) ->
        console.log textStatus, errorThrown
      success: (result) ->
        res = "#votevalue"+commentid
        if result.vote
          val = $(res).text()
          $(res).text(parseInt(val) - 1)
        console.log result

$(document).ready(ready)
$(document).on('page:load', ready)