module ApplicationHelper
  def background_image_url(image)
    return {} unless image

    { style: "background-image: url(#{cl_image_path(image.path, width: 1200, crop: :lfill, quality: :auto, flags: "lossy")});" }
  end

  def rating_options(rateable)
    options_for_select(1..5, rateable.rating)
  end

  def display_datetime(datetime)
    if datetime
      datetime.strftime("%B %e, %Y")
    end
  end
end
