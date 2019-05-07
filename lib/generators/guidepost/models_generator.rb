require "rails/generators/base"

module Guidepost
    module Generator
        class ModelsGenerator < Rails::Generators::Base
            def hello_world
                puts "Hello world"
            end
        end
    end
end