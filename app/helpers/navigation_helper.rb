module NavigationHelper
  def nav_link text, url
    if current_page?(url)
      link_to content_tag(:li, text), url, class: 'current'
    else
      link_to content_tag(:li, text), url
    end
  end
end
