$s3_config = OpenStruct.new(YAML.load(ERB.new(
  File.read("config/s3.yml")
).result)[Rails.env])

CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: $s3_config.aws_access_key_id,
    aws_secret_access_key: $s3_config.aws_secret_access_key,
    region: $s3_config.region
  }

  config.fog_public = true
  config.fog_directory = $s3_config.bucket
  config.fog_attributes = {
    'Cache-Control' => $s3_config.cache_control
  }

  config.remove_previously_stored_files_after_update = false

  if Rails.env.test?
    config.storage :file
    config.enable_processing = false
  else
    config.storage :fog
    if ENV['MEDIA_HOST_NAME_TRAINING_PPSDMK'].present?
      config.asset_host = ENV['MEDIA_HOST_NAME_TRAINING_PPSDMK']
    end
  end

  if Rails.env.development?
    config.ignore_integrity_errors = false
    config.ignore_processing_errors = false
    config.ignore_download_errors = false
  end
end
