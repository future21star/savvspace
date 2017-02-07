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
