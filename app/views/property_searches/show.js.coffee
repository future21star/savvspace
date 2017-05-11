$("#more-link").replaceWith("<%= j(render partial: 'property_searches/index', locals: {property_search: @property_search}) %>")
