module RetinaHelper
  def retina_image_tag name_at_1x, options={}
    name_at_2x = name_at_1x.gsub(%r{\.\w+$}, '@2x\0')
    image_tag asset_path(name_at_1x), options.merge("data-at2x" => asset_path(name_at_2x))
  end

  def asset_host_url path
    URI.join(config.asset_host, asset_path(path))
  end
end