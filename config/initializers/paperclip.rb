Paperclip.interpolates(:placeholder) do |attachment, style|
    ActionController::Base.helpers.asset_path("missing.png")
end

Paperclip::Attachment.default_options[:url] = ':s3_domain_url'
Paperclip::Attachment.default_options[:path] = '/:class/:attachment/:id_partition/:style/:filename'
