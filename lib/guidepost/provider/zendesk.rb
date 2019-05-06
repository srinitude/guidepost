module Guidepost
    module Provider
        class Zendesk
            attr_accessor :subdomain

            def initialize(options={})
                @subdomain = options[:subdomain]
                @storage = options[:storage] || Guidepost::Storage::S3.new

                @email = "#{ENV["GUIDEPOST_ZENDESK_EMAIL"]}/token"
                @password = ENV["GUIDEPOST_ZENDESK_PASSWORD_TOKEN"]
            end

            def backup_all_articles
                # Get all articles (with pagination)
                articles = self.retrieve_all_articles
        
                # Upload to S3
                timestamp = Time.now.strftime('%Y%m%d%H%M%S')
                @storage.upload_guides("zendesk/article_backups/#{timestamp}.json", articles.to_json)
        
                articles.count
            end
        
            def retrieve_all_articles
                articles = []
                page_next = nil
                while true
                    page_articles, page_next = self.retrieve_articles(page_next)
                    break if page_articles.nil? || page_articles.empty?
                    articles += page_articles
                    break if page_next.nil?
                end
                articles
            end
        
            def retrieve_articles(url)
                url = "#{self.base_api_url}/help_center/articles.json?include=users,sections,categories,translations&per_page=25&page=1" if url.nil?
                
                uri = URI.parse(url)
        
                http = Net::HTTP.new(uri.host, uri.port)
                http.use_ssl = true
                http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        
                request = Net::HTTP::Get.new(uri.request_uri)
                request.basic_auth(@email, @password)
                response = http.request(request)
        
                body = response.body.force_encoding("UTF-8")
        
                j_body = JSON.parse(body)
                return j_body['articles'], j_body['next_page']
            end

            def base_api_url
                "https://#{self.subdomain}.zendesk.com/api/v2"
            end
        end
    end 
end