module ProfilesHelper
  def facebook_link(username)
    common_service_link(username, "facebook", "www.facebook.com")
  end

  def instagram_link(username)
    common_service_link(username, "instagram", "www.instagram.com")
  end

  def twitter_link(username)
    common_service_link(username, "twitter", "twitter.com")
  end

  def linked_in_link(username)
    common_service_link(username, "linkedin", "www.linkedin.com/in")
  end

  def common_service_link(username, service_name, domain)
    if username.present?
      link_to("https://#{domain}/" + username,
              class: "icon icon-#{service_name}",
              title: service_name.capitalize,
              target: "_blank") do
        ""
      end
    end
  end
end
