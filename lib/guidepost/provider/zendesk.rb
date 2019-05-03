module Guidepost
    module Provider
        class Zendesk
            attr_accessor :subdomain

            def initialize(options={})
                @subdomain = options[:subdomain]
                @s3 = options[:s3] || Guidepost::Storage::S3.new

                @email = "#{ENV["GUIDEPOST_ZENDESK_EMAIL"]}/token"
                @password = ENV["GUIDEPOST_ZENDESK_PASSWORD_TOKEN"]
            end

            def backup_all_articles
                page = 1
                while true
                    page = backup_articles(from_page: page)
                    break if page.nil?
                end
            end

            def backup_articles(options={})
                page = options[:from_page]
                page = 1 if page.nil?
        
                articles = retrieve_articles(from_page: page)
        
                timestamp = Time.now.strftime '%Y%m%d'
                s3_api_service.upload_file("zendesk/article_backups/#{timestamp}/pages/page-#{articles[:page]}.json", articles[:body])
        
                body = JSON.parse(articles[:body])
                
                return nil if body["next_page"].nil?
        
                query = URI.parse(body["next_page"]).query
                query_params = CGI::parse(query)
                
                query_params["page"].first
            end

            def retrieve_articles(options={})
                page = options[:from_page]
                page = 1 if page.nil?
        
                url = "#{self.base_api_url}/help_center/articles.json?include=users,sections,categories,translations&per_page=100&page=#{page}"
                uri = URI.parse(url)
        
                http = Net::HTTP.new(uri.host, uri.port)
                http.use_ssl = true
                http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        
                request = Net::HTTP::Get.new(uri.request_uri)
                request.basic_auth(@email, @password)
                response = http.request(request)
        
                body = response.body.force_encoding("UTF-8")
        
                {
                    page: page,
                    body: body
                }
            end

            def base_api_url
                "https://#{self.subdomain}.zendesk.com/api/v2"
            end
        end
    end 
end