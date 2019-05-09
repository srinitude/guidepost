require "rails/generators/base"

module Guidepost
    module Generators
        
        class MigrateGenerator < Rails::Generators::Base
            desc "This generator performs the schema and data migrations associated with your current Zendesk guides"

            def self.default_generator_root
                File.dirname(__FILE__)
            end

            def schema_migration
                `rake db:migrate`             
            end

            def data_migration
                `rake zendesk_guide:`
            end
        end

    end
end