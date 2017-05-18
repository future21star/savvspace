module BootstrapHelper
  def tab_nav_list
    { class: ['nav', 'nav-tabs'] }
  end

  def tab_nav_item
    { role: 'presentation' }
  end

  def tab_link(text, tab_name)
    link_to(text, "##{tab_name}", role: 'tab', data: { toggle: 'tab' },
                                  aria: { controls: 'tab_name' })
  end

  def glyphicon(icon_name, text = nil)
    capture_haml do
      haml_tag("span.glyphicon.glyphicon-#{icon_name}", text, nil, aria: { hidden: true })
    end
  end
end
