require "rails/generators/base"

module Guidepost
    module Generators
        
        class ModelsGenerator < Rails::Generators::Base
            desc "This generator creates the migrations, models, and tests associated with your current Zendesk guides"

            def self.default_generator_root
                File.dirname(__FILE__)
            end

            def migrations
                timestamp = Time.now.strftime('%Y%m%d%H%M%S')
                template "migrations.rb", "db/migrate/#{timestamp}_create_zendesk_guide_models.rb"                
            end

            def models

            end

            def tests
                
            end
        end

    end
end