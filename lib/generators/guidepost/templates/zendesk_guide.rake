namespace :zendesk_guide do

    desc "Backup articles from knowledge base provider (i.e. Zendesk currently) [customize this task if you want to add more functionality]"
    task :backup_articles, [:subdomain, :project_name] => :environment do |t, args|
        begin
            subdomain = args[:subdomain]
            project_name = args[:project_name]

            if subdomain.nil? || project_name.nil?
                raise "Subdomain and/or project_name arguments are missing" if Rails.env.development?
            end
            
            zendesk = Guidepost::Provider::Zendesk.new(subdomain: subdomain, project_name: project_name)
            zendesk.backup_all_articles(sideload: true)
        rescue => e
            raise e if Rails.env.development?
        end
    end

    desc "Import guides and respective models into database [customize this task if you want to add more functionality]"
    task :import_guides_into_database, [:subdomain, :project_name] => :environment do |t, args|
        begin
            subdomain = args[:subdomain]
            project_name = args[:project_name]

            if subdomain.nil? || project_name.nil?
                raise "Subdomain and/or project_name arguments are missing" if Rails.env.development?
            end

            zendesk = Guidepost::Provider::Zendesk.new(subdomain: subdomain, project_name: project_name)
            articles_sections_and_categories = zendesk.retrieve_all_articles(sideload: true)

            categories = articles_sections_and_categories[:categories]
            category_objects = []
            ZendeskGuideCategory.find_or_create_categories(categories: categories, category_objects: category_objects)

            sections = articles_sections_and_categories[:sections]
            section_objects = []
            ZendeskGuideSection.find_or_create_sections(
                sections: sections, 
                section_objects: section_objects, 
                category_objects: category_objects
            )

            user_segments = zendesk.retrieve_all_user_segments
            user_segment_objects = []
            ZendeskGuideUserSegment.find_or_create_user_segments(user_segments: user_segments, user_segment_objects: user_segment_objects)

            permission_groups = zendesk.retrieve_all_permission_groups
            permission_group_objects = []
            ZendeskGuidePermissionGroup.find_or_create_permission_groups(permission_groups: permission_groups, permission_group_objects: permission_group_objects)

            articles = articles_sections_and_categories[:articles]
            article_objects = []
            ZendeskGuideArticle.find_or_create_articles(
                articles: articles,
                article_objects: article_objects,
                section_objects: section_objects,
                user_segment_objects: user_segment_objects,
                permission_group_objects: permission_group_objects
            )                

            article_attachments = zendesk.retrieve_all_article_attachments(articles: articles)
            ZendeskGuideArticleAttachment.find_or_create_article_attachments(article_attachments: article_attachments, article_objects: article_objects)                
        rescue => e
            raise e if Rails.env.development?
        end
    end

end