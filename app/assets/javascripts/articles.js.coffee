# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  $("#voteup").click ->
    $articleid = $(this).data "article-id"
    $.ajax
      url: '/articles/' + $articleid + '/voteup'
      type: 'GET'
      error: (jqXHR, textStatus, errorThrown) ->
        console.log textStatus, errorThrown
      success: (result) ->
        # location.reload()
        res = "#votevalue"+$articleid
        # alert res
        $(res).text(result.vote)
        console.log result
        # console.log $("#votevalue"+$articleid)

$(document).ready(ready)
$(document).on('page:load', ready)