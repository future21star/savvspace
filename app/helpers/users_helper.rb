module UsersHelper
  def profile_image(user)
    if user && user.profile.avatar
      cl_image_tag(current_user.profile.avatar.path, {size: '35x35', crop: :thumb, gravity: :face, class: "img-circle"})
    else
      image_tag("blank-profile.png", height: 33, class: "img-circle")
    end
  end
end