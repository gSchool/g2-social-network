if Rails.env.test?
  CarrierWave.configure do |config|
    config.storage = :file
    config.enable_processing = false
  end
else
  CarrierWave.configure do |config|
    config.fog_credentials = {
      :provider => 'AWS',
      :aws_access_key_id => 'AKIAIGICFNEZKECSWTIQ',
      :aws_secret_access_key => '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',
      #:region                 => 'eu-west-1',                  # optional, defaults to 'us-east-1'
      #:host                   => 's3.example.com',             # optional, defaults to nil
      #:endpoint               => 'https://s3.example.com:8080' # optional, defaults to nil
    }
    config.fog_directory = 'g2-social-networking-development' # required
    #config.fog_public     = false                                   # optional, defaults to true
    #config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
  end
end
