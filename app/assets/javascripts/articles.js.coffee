# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  $(".voteup").click (event) ->
    event.preventDefault()
    obj = $(this)
    voting(true, obj)
        # alert res        
        # location.reload()

  $(".votedown").click (event) ->
    event.preventDefault()
    obj = $(this)
    voting(false, obj)

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


# voting function takes two parameters
# if first parameter is true the raiting counter is incremented by 1, else counter is decremented by 1
# second parameter is handler to object

voting = (updown, objct) ->
  if updown
    urlpath = '/voteup'
    weight = 1
    backcolor = "#449D44"
  else
    urlpath = '/votedown'
    weight = -1
    backcolor = "#C9302C"
  articleid = objct.data "article-id"
  objct.parent().hide("slow")
  $.ajax
      url: '/articles/' + articleid + urlpath
      type: 'POST'
      error: (jqXHR, textStatus, errorThrown) ->
        console.log textStatus, errorThrown
      success: (result) ->
        res = "#votevalue"+articleid
        if result.vote
          val = $(res).text()
          $(res).text(parseInt(val) + weight)
          backgr = $(res).css("background-color")
          $(res).css("background-color": backcolor).animate
            "background-color": backgr
          , 1000
        console.log result
