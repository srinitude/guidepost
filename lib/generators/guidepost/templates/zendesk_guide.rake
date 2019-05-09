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
            sections = articles_sections_and_categories[:sections]

            # Retrieve all user segments
            # Retrieve all permission groups
            # Retrieve all article attachments
        rescue => e
            raise e if Rails.env.development?
            mailer.error_notification("An error happened during rake zendesk_guide:import_guides_into_database", e).deliver_now
        end
    end
end