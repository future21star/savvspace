# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

@refreshRatings = (selector) ->
        if (selector)
                $(selector).barrating("show", {"theme": "bootstrap-stars"})
        else
                $("select.rating[readonly=readonly]").barrating("show", {"theme": "bootstrap-stars", "readonly": true})
                $("select.rating[readonly!=readonly]").barrating("show", {"theme": "bootstrap-stars"})

$(document).on "change", "select.rating", (event) ->
        $(this).closest("form").submit()

$(document).on "turbolinks:load", ->
        refreshRatings()
