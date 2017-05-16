window.getObjects = (obj, key, val) ->
  objects = [];
  for i of obj
    if (!obj.hasOwnProperty(i))
      continue
    if typeof obj[i] == 'object'
      objects = objects.concat(getObjects(obj[i], key, val))
    else if i == key && obj[key] == val
      objects.push(obj)
  objects

hideAlerts = () ->
  $('div.alert-dismissable').slideToggle()

$(document).on "turbolinks:load", ->
  if($('.attachinary-input').length > 0)
    $('.attachinary-input').attachinary()

  $('.carousel').carousel()
  $.cloudinary.responsive()
  $('.wysihtml5-sandbox').css("resize", "vertical")
  $("[data-toggle=dropdown]").dropdown()

  setTimeout(hideAlerts, 5000) if ($('div.alert-dismissable'))

  $("div[href]").addClass("clickable")
  $("select.multiple").multiselect({includeSelectAllOption: true})
  $("div[href]").click ->
    window.location = $(this).attr("href")
