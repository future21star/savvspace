module ApplicationHelper
  def background_image_url(image)
    return {} unless image

    { style: "background-image: url(#{image.fullpath});" }
  end

  def rating_options(rateable)
    options_for_select(1..5, rateable.rating)
  end
end
