# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

setProfileUrlHint = () ->
  return false unless $("input#profile_username")
  $(".form-group.profile_username .help-block").html("Claim your personal URL: https://savvspace.com/u/" + $("input#profile_username").val())

$(document).on "turbolinks:load", ->
  setProfileUrlHint()
  $("input#profile_username").keyup ->
    setProfileUrlHint()

  $("#new_call").on 'hidden.bs.modal', (e) ->
    $.ajax({url: "/phone_calls/new.js", data: {profile_id: $("#new_call").data("profileId")}})
    return

  past_avata_values = JSON.parse($('.profile_past_avatars .attachinary_container input').val())
  $past_avata_imgs = $('.profile_past_avatars ul li img')
  $avatar_img = $('.profile_avatar .attachinary_container li img')
  $avatar_action = $('.profile_avatar .attachinary_container li a')
  $avatar_img_val = $('.profile_avatar .attachinary_container input')
  $past_avata_imgs.each ->
    $(this).click ->
      path = $(this).attr('src')
      path_data = path.split('/')
      public_id = path_data[path_data.length - 1].split('.')[0]
      avatar_obj = window.getObjects(past_avata_values, 'public_id', public_id)
      $avatar_img.attr 'src', path
      $avatar_action.attr 'data-remove', public_id
      $avatar_img_val.val JSON.stringify(avatar_obj)
      return
    return
