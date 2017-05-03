module PropertiesHelper
  def property_poster_image_url(property)
    bgimg = property.photos.first
    if bgimg
      cl_image_path(bgimg, type: :fetch, crop: :lfill, height: 230, width: 378, quality: "auto", flags: "lossy")
    else
      image_path('no_property_photo')
    end
  end
end
