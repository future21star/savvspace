module ApplicationHelper
  def background_image_url(image)
    return {} unless image

    { style: "background-image: url(#{image.fullpath});" }
  end
end
