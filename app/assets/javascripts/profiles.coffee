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

  if $('.past-avatar').length > 0 and !! $(".profile_avatar .attachinary_container input").val()
    cur_avatar = JSON.parse($(".profile_avatar .attachinary_container input").val())
    $past_avata_imgs = $('.past-avatars img')
    $avatar_img = $('.profile_avatar .attachinary_container li img')
    $avatar_action = $('.profile_avatar .attachinary_container li a')
    $avatar_img_val = $('.profile_avatar .attachinary_container input')
    $past_avata_imgs.each ->
      $(this).click ->
        public_id = $(this).attr('alt').toLowerCase()
        cur_avatar[0]["public_id"] = public_id
        $avatar_img.attr 'src', $(this).attr('src')
        $avatar_action.attr 'data-remove', public_id
        $avatar_img_val.val JSON.stringify(cur_avatar)
        return
      return
