initMap = (element) ->
        $(element).googleMap({ zoom: element.data("zoom"), coords : [element.data("lat"), element.data("lng")] })
        $(element).addMarker({ coords : [element.data("lat"), element.data("lng")] })

$(document).on "turbolinks:load", ->
        $('.google-map').each (index) ->
          initMap $(this)
          return
