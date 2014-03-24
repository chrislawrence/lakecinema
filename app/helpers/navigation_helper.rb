module NavigationHelper
  def nav_link text, url, options = {}
    if current_page?(url)
      link_to content_tag(:li, text), url, options.merge(class: "#{options[:class]} current")
    else
      link_to content_tag(:li, text), url, options
    end
  end
end
