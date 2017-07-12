CarrierWave.configure do |config|
  if Rails.env.development?
    config.storage :file
  else
    config.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:     Setting.AWS_ACCESS_KEY_ID,
      aws_secret_access_key: Setting.AWS_SECRET_ACCESS_KEY,
      region:                Setting.AWS_REGION
    }
    config.storage = :fog
    config.fog_directory  =  Setting.AWS_S3_BUCKET
  end
end