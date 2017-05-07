$("#property-list").html("<%= j(render partial: 'property_searches/index', locals: {properties: @results}) %>")
$("form.processing").removeClass("processing")
