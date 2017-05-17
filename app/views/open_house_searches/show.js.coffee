$("#more-link").replaceWith("<%= j(render partial: 'open_house_searches/index', locals: {property_search: @property_search}) %>")
