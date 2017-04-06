hideAlerts = () ->
        $('div.alert-dismissable').slideToggle()

$(document).on "turbolinks:load", (event) ->
        $('.attachinary-input').attachinary()
        $('.carousel').carousel()
        $.cloudinary.responsive()
        $('.wysihtml5-sandbox').css("resize", "vertical")
        $("[data-toggle=dropdown]").dropdown()

        setTimeout(hideAlerts, 5000) if ($('div.alert-dismissable'))

        $("div[href]").addClass("clickable")
        $("div[href]").click ->
                window.location = $(this).attr("href")

        if typeof ga is 'function'
          ga('set', 'location', event.data.url)
          ga('send', 'pageview')
