module SuppliersHelper
  def dragonfly_app
    Dragonfly[:images]
  end

  def sized_image(image, size)
      if image != nil
        if image.attachment.to_file != nil
          image_tag(dragonfly_app.fetch_file(image.attachment.to_file.path).thumb(size).url)
        end
      else
        noimage = File.open(File.join(Rails.root, "public", "images", "noimage", "product.jpg"))
        image_tag(dragonfly_app.fetch_file(noimage.path).thumb(size).url)
      end
    end
end
