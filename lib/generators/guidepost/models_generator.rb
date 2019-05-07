require "rails/generators/base"

module Guidepost
    module Generators
        
        module Zendesk
            class ModelsGenerator < Rails::Generators::Base
                def migrations
                    puts "Hello world"
                end
            end
        end

    end
end