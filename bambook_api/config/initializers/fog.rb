CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'                        # required
  config.fog_credentials = {
      provider:              'AWS',                        # required
      aws_access_key_id:     Rails.application.secrets.access_key_id,
      aws_secret_access_key: Rails.application.secrets.secret_access_key,
      region:                'us-east-1',                  # optional, defaults to 'us-east-1'
  }
  config.fog_directory  = 'ololol'                                      # required
  config.fog_public     = false                                                 # optional, defaults to true
  config.fog_attributes = { cache_control: "public, max-age=#{365.days.to_i}" } # optional, defaults to {}
end