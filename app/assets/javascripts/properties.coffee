# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

decorateCancelNotesButton = () ->
        $("a.cancel-notes").click ->
                $(this).closest(".panel-body").removeClass("notes")
                return false

$(document).on "turbolinks:load ajaxComplete", ->
        decorateCancelNotesButton()

$ ->
  $('a').bind 'ajax:error', (event, jqXHR, ajaxSettings, thrownError) ->
    if jqXHR.status == 401 # thrownError is 'Unauthorized'
      window.location.replace('/users/sign_in')
