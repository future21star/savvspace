hideAlerts = () ->
        $('div.alert-dismissable').slideToggle()

$(document).on "turbolinks:load", ->
        $('.attachinary-input').attachinary()
        $('.wysihtml5-sandbox').css("resize", "vertical")
        $("[data-toggle=dropdown]").dropdown()

        setTimeout(hideAlerts, 5000) if ($('div.alert-dismissable'))
