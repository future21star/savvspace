module ArticlesHelper
  def area_options
    return [] unless current_user

    areas = current_user.ambassadorships.collect(&:area)
    areas.concat(current_user.role_for_what('author', Area))
    areas.uniq
  end
end
