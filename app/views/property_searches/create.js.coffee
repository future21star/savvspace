$("#property-list").html("<%= j(render partial: 'property_searches/index', locals: {property_search: @property_search}) %>")
$("form.processing").removeClass("processing")
