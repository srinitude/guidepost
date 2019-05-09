namespace :zendesk_guide do

    desc "Backup articles from knowledge base provider (i.e. Zendesk currently) [run from Rails console to instantiate your mailer object]"
    task :backup_articles, [:subdomain, :project_name, :mailer] => :environment do |t, args|
        begin
            subdomain = args[:subdomain]
            project_name = args[:project_name]
            mailer = args[:mailer]

            if subdomain.nil? || project_name.nil? || mailer.nil?
                raise "Subdomain, project name, and/or mailer arguments are missing" if Rails.env.development?
                mailer.error_notification("An error happened during rake zendesk_guide:backup_articles", e).deliver_now
                return
            end
            
            zendesk = Guidepost::Provider::Zendesk.new(subdomain: subdomain, project_name: project_name)
            zendesk.backup_all_articles(sideload: true)
        rescue => e
            raise e if Rails.env.development?
            mailer.error_notification("An error happened during rake zendesk_guide:backup_articles", e).deliver_now
        end
    end

    desc "Import guides and respective models into database [run from Rails console to instantiate your mailer object]"
    task :import_guides_into_database, [:subdomain, :project_name, :mailer] => :environment do |t, args|
        begin
            subdomain = args[:subdomain]
            project_name = args[:project_name]
            mailer = args[:mailer]

            if subdomain.nil? || project_name.nil? || mailer.nil?
                raise "Subdomain, project name, and/or mailer arguments are missing" if Rails.env.development?
                mailer.error_notification("An error happened during rake zendesk_guide:backup_articles", e).deliver_now
                return
            end

            zendesk = Guidepost::Provider::Zendesk.new(subdomain: subdomain, project_name: project_name)
            articles_sections_and_categories = zendesk.retrieve_all_articles(sideload: true)

            categories = articles_sections_and_categories[:categories]
            category_objects = []

            # Iterate through categories
                # Change the key names of certain fields according to the name in the schema
                # Try to find the ZendeskGuideCategory with the category hash
                # Create the ZendeskGuideCategory if the model doesn't exist
                # Add ZendeskGuideCategory to category_objects

            sections = articles_sections_and_categories[:sections]
            section_objects = []

            # Iterate through sections
                # Change the key names of certain fields according to the name in the schema
                # Try to find the ZendeskGuideSection with the section hash
                # Create the ZendeskGuideSection if the model doesn't exist
                # Loop through category_objects
                    # Check to see if new ZendeskGuideSection's category_id matches the category's category_id
                    # If it does, associate the ZendeskGuideSection's category with category from the loop and save the ZendeskGuideSection
                # Add ZendeskGuideSection to section_objects

            # Query all user segments
            user_segments = zendesk.retrieve_user_segments
            user_segment_objects = []

            # Iterate through user_segments
                # Change the key names of certain fields according to the name in the schema
                # Try to find the ZendeskGuideUserSegment with the user segment hash
                # Create the ZendeskGuideUserSegment if the model doesn't exist
                # Add ZendeskGuideUserSegment to user_segment_objects

            # Retrieve all permission groups
            permission_groups = zendesk.retrieve_permission_groups
            permission_group_objects = []

            # Iterate through permission_groups
                # Change the key names of certain fields according to the name in the schema
                # Try to find the ZendeskGuidePermissionGroup with the user segment hash
                # Create the ZendeskGuidePermissionGroup if the model doesn't exist
                # Add ZendeskGuidePermissionGroup to permission_group_objects

            # Retrieve all articles
            articles = articles_sections_and_categories[:articles]
            article_objects = []

            # Iterate through articles
                # Change the key names of certain fields according to the name in the schema
                # Try to find the ZendeskGuideArticle with the article hash
                # Create the ZendeskGuideArticle if the model doesn't exist
                # changed = false
                # Loop through section_objects
                    # Check to see if new ZendeskGuideArticle's section_id matches the section's section_id
                    # If it does, associate the ZendeskGuideArticle's section with section from the loop
                    # changed = true
                # Loop through user_segment_objects
                    # Check to see if new ZendeskGuideArticle's user_segment_id matches the user_segment's user_segment_id
                    # If it does, associate the ZendeskGuideArticle's user_segment with user_segment from the loop
                    # changed = true
                # Loop through permission_group_objects
                    # Check to see if new ZendeskGuideArticle's permission_group_id matches the permission_group's permission_group_id
                    # If it does, associate the ZendeskGuideArticle's permission_group with permission_group from the loop
                    # changed = true
                # Save ZendeskGuideArticle if changed == true
                # Add ZendeskGuideArticle to article_objects
                

            # Retrieve all article attachments
            article_attachments = zendesk.retrieve_all_article_attachments(articles: articles)

            # Iterate through article_attachments
                # Change the key names of certain fields according to the name in the schema
                # Try to find the ZendeskGuideArticleAttachment with the article hash
                # Create the ZendeskGuideArticleAttachment if the model doesn't exist
                # Loop through article_objects
                    # Check to see if new ZendeskGuideArticleAttachment's article_id matches the article's article_id
                    # If it does, associate the ZendeskGuideArticleAttachment's article with article from the loop and save
                
        rescue => e
            raise e if Rails.env.development?
            mailer.error_notification("An error happened during rake zendesk_guide:import_guides_into_database", e).deliver_now
        end
    end
end