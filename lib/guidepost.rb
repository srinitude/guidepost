require 'aws-sdk'
require 'cgi'
require 'json'
require 'net/http'
require 'set'

module Guidepost

    module Provider
        autoload :Zendesk,  'guidepost/provider/zendesk'
    end

    module Storage
        autoload :S3,       'guidepost/storage/s3'
    end
    
end