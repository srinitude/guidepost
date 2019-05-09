module Guidepost
    module Provider
        class Zendesk
            attr_reader :subdomain
            attr_reader :project_name

            def initialize(options={})
                @subdomain = options[:subdomain]
                @project_name = options[:project_name]

                raise "Guidepost::Provider::Zendesk initializer is missing either a subdomain or project_name" if @subdomain.nil? || @project_name.nil?

                @project_name.upcase!
                @storage = options[:storage] || Guidepost::Storage::S3.new(project_name: @project_name)

                @email = "#{ENV["#{@project_name}_GUIDEPOST_ZENDESK_EMAIL"]}/token"
                @password = ENV["#{@project_name}_GUIDEPOST_ZENDESK_PASSWORD_TOKEN"]
            end

            def backup_all_articles(options={})
                # Get all articles (with pagination)
                sideload = options[:sideload] || false
                articles = self.retrieve_all_articles(sideload: sideload)
        
                # Upload to S3
                timestamp = Time.now.strftime('%Y%m%d%H%M%S')
                @storage.upload_file(path: "zendesk/article_backups/#{timestamp}.json", string_content: articles.to_json)
        
                articles.count
            end
        
            def retrieve_all_articles(options={})
                sideload = options[:sideload] || false
                page_next = nil
                articles = []

                if !sideload
                    while true
                        page_articles, page_next = self.retrieve_articles(url: page_next)
                        break if page_articles.nil? || page_articles.empty?
                        articles += page_articles
                        break if page_next.nil?
                    end
                    return articles
                else
                    sections = []
                    categories = []

                    section_urls = Hash.new
                    category_urls = Hash.new

                    while true
                        page, page_next = self.retrieve_articles(url: page_next, sideload: true)

                        articles_from_page = page["articles"]
                        sections_from_page = page["sections"]
                        categories_from_page = page["categories"]

                        no_more_articles = articles_from_page.nil? || articles_from_page.empty?
                        no_more_sections = sections_from_page.nil? || sections_from_page.empty?
                        no_more_categories = categories_from_page.nil? || categories_from_page.empty?

                        break if no_more_articles && no_more_sections && no_more_categories

                        articles += articles_from_page

                        sections_from_page.each do |s|
                            url = s["url"]
                            if !section_urls.has_key?(url)
                                section_urls[url] = 1
                            else
                                section_urls[url] += 1
                            end
                            sections << s if section_urls[url] == 1
                        end

                        categories_from_page.each do |c|
                            url = c["url"]
                            if !category_urls.has_key?(url)
                                category_urls[url] = 1
                            else
                                category_urls[url] += 1
                            end
                            categories << c if category_urls[url] == 1
                        end

                        break if page_next.nil?
                    end

                    return { 
                        categories: categories, 
                        category_count: categories.count, 
                        sections: sections, 
                        section_count: sections.count, 
                        articles: articles,
                        article_count: articles.count
                    }
                end
            end
        
            def retrieve_articles(options={})
                url = options[:url]
                sideload = options[:sideload] || false

                if !sideload
                    url = "#{self.base_api_url}/help_center/articles.json?include=&per_page=25&page=1" if url.nil?
                else
                    url = "#{self.base_api_url}/help_center/articles.json?include=sections,categories&per_page=25&page=1" if url.nil?
                end
                
                uri = URI.parse(url)
        
                http = Net::HTTP.new(uri.host, uri.port)
                http.use_ssl = true
                http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        
                request = Net::HTTP::Get.new(uri.request_uri)
                request.basic_auth(@email, @password)
                response = http.request(request)
        
                body = response.body.force_encoding("UTF-8")
        
                j_body = JSON.parse(body)

                if !sideload
                    return j_body['articles'], j_body['next_page']
                else
                    return j_body, j_body['next_page']
                end
            end

            def base_api_url
                "https://#{self.subdomain}.zendesk.com/api/v2"
            end
        end
    end 
end