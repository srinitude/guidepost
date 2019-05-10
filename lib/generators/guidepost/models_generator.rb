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
                template "zendesk_guide.rake", "lib/tasks/zendesk_guide.rake"                
            end

            def models
                model_templates = [
                    "zendesk_guide_category.rb", 
                    "zendesk_guide_section.rb", 
                    "zendesk_guide_article.rb",
                    "zendesk_guide_article_attachment.rb",
                    "zendesk_guide_permission_group.rb",
                    "zendesk_guide_user_segment.rb"
                ]
                model_templates.each do |t|
                    template t, "app/models/#{t}"
                end
            end
        end

    end
end