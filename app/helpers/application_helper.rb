module ApplicationHelper
    #ApplicationHelper
    def my_image_tag(source, options={})
      options[:alt] = "my-default"
      image_tag(source, options)
    end
end
