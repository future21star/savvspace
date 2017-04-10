$("#property-list").html("<%= j(render partial: 'open_house_searches/index', locals: {properties: @results}) %>")
$("form.processing").removeClass("processing")
