$("#property-list").html("<%= j(render partial: 'property_searches/index', locals: {properties: @results, referrer_id: @profile.id}) %>")
$("form.processing").removeClass("processing")
