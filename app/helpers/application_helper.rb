module ApplicationHelper
  def background_image_url(image, width = 'auto')
    return {} unless image
    img_url = cl_image_path(image.path, width: width, crop: :lfill, quality: :auto,
                                        gravity: :auto, flags: 'lossy')
    { style: "background-image: url(#{img_url});" }
  end

  def rating_options(rateable)
    options_for_select(1..5, rateable.rating)
  end

  def display_datetime(datetime)
    datetime.strftime('%B %e, %Y') if datetime
  end
end
