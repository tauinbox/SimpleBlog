# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


# voting function takes two parameters
# if first parameter is true the raiting counter is incremented by 1, else counter is decremented by 1
# second parameter is handler to object

voting = (up, objct, entity) ->

  switch(true)
    when (entity is "article")
      articleid = objct.data "article-id"

      res = "#votevalue" + articleid
      if up
        urlpath = '/articles/' + articleid + '/voteup'
        weight = 1
        backcolor = "#449D44"
      else
        urlpath = '/articles/' + articleid + '/votedown'
        weight = -1
        backcolor = "#C9302C"

    when (entity is "comment")
      commentid = objct.data "comment-id"
      articleid = objct.data "article-id"
      
      res = "#votevalue" + commentid
      if up
        urlpath = '/articles/' + articleid + '/comments/' + commentid + '/voteup'
        weight = 1
        backcolor = "#449D44"
      else
        urlpath = '/articles/' + articleid + '/comments/' + commentid + '/votedown'
        weight = -1
        backcolor = "#C9302C"
  
  objct.parent().hide("slow")
  $.ajax
      url: urlpath
      type: 'GET'
      error: (jqXHR, textStatus, errorThrown) ->
        console.log textStatus, errorThrown
      success: (result) ->
        if result.vote
          val = $(res).text()
          $(res).text(parseInt(val) + weight)
          backgr = $(res).css("background-color")
          $(res).css("background-color": backcolor).animate
            "background-color": backgr
          , 1000
        console.log result

ready = ->
  $(".voteup").click (event) ->
    event.preventDefault()
    obj = $(this)
    voting(true, obj, "article")
        # alert res        
        # location.reload()

  $(".votedown").click (event) ->
    event.preventDefault()
    obj = $(this)
    voting(false, obj, "article")

  $(".voteupc").click (event) ->
    event.preventDefault()
    obj = $(this)
    voting(true, obj, "comment")

  $(".votedownc").click (event) ->
    event.preventDefault()
    obj = $(this)
    voting(false, obj, "comment")

  $("#article-img").filestyle 
    buttonText: "Хочу добавить картинку"
    buttonName: "btn-info"
    input: false

  $("#profile-img").filestyle 
    buttonText: "Загрузить файл аватара"
    buttonName: "btn-info"
    input: false

$(document).ready(ready)
$(document).on('page:load', ready)

