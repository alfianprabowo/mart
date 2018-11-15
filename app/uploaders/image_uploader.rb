class ImageUploader < CarrierWave::Uploader::Base

  VALID_CONTENT_TYPES = ["image/jpeg", "image/png", "image/gif"]

  def store_dir
    "uploads/#{model.class.base_class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def filename
    "#{secure_token}.#{file.extension}" if original_filename.present?
  end

  def default_url(*args)
    ActionController::Base.helpers.image_path "default.jpg"
  end

  def content_type_whitelist
    VALID_CONTENT_TYPES
  end

  private
    def secure_token(length=16)
      var = :"@#{mounted_as}_secure_token"
      model.instance_variable_get(var) or
        model.instance_variable_set(var, SecureRandom.hex(length/2))
    end
end
