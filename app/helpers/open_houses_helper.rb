module OpenHousesHelper
  def event_date(open_house)
    format("%s %s-%s",
           open_house.starts_at.strftime("%a"),
           open_house.starts_at.strftime("%l"),
           open_house.ends_at.strftime("%l %p").strip)
  end

  def open_house_poster_image_url(open_house)
    bgimg = open_house.photo_url
    if bgimg
      cl_image_path(bgimg, type: :fetch, crop: :lfill, height: 230, width: 378, quality: "auto", flags: "lossy")
    else
      image_path('no_property_photo')
    end
  end
end
