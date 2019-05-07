require "rails/generators/base"

module Guidepost
    module Generators
        
        class ModelsGenerator < Rails::Generators::Base
            def migrations
                puts "Hello world"
            end
        end

    end
end