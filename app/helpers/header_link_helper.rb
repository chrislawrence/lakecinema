module HeaderLinkHelper
  def header_link_path 
    if controller_name == 'static' 
      root_path
    else
      admin_path
    end
  end
end
