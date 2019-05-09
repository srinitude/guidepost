class ZendeskGuideArticle < ActiveRecord::Base
    belongs_to :zendesk_guide_section
    belongs_to :zendesk_guide_user_segment
    belongs_to :zendesk_guide_permission_group

    has_many :zendesk_guide_article_attachments

    validates :title, presence: true
    validates :locale, presence: true

    def self.find_or_create_articles(options={})
        articles = options[:articles]
        article_objects = options[:article_objects]
        section_objects = options[:section_objects]
        user_segment_objects = options[:user_segment_objects]
        permission_group_objects = options[:permission_group_objects]

        articles.each do |a|
            article_hash = a.clone

            article_hash[:article_id] = article_hash["id"]
            article_hash.delete("id")

            article_hash[:article_created_at] = article_hash["created_at"]
            article_hash.delete("created_at")

            article_hash[:article_updated_at] = article_hash["updated_at"]
            article_hash.delete("updated_at")

            article_hash.symbolize_keys!

            article = ZendeskGuideArticle.where(article_hash).first
            article.update(article_hash) if !article.nil?
            article = ZendeskGuideArticle.create(article_hash) if article.nil?
            
            changed = false

            section_objects.each do |so|
                is_correct_section = (article.section_id == so.section_id)
                if is_correct_section
                    article.zendesk_guide_section = so
                    changed = true
                end
            end

            user_segment_objects.each do |us|
                is_correct_user_segment = (article.user_segment_id == us.user_segment_id)
                if is_correct_user_segment
                    article.zendesk_guide_user_segment = us
                    changed = true
                end
            end

            permission_group_objects.each do |pg|
                is_correct_permission_group = (article.permission_group_id == pg.permission_group_id)
                if is_correct_permission_group
                    article.zendesk_guide_permission_group = pg
                    changed = true
                end
            end

            article.save if changed

            article_objects << article
        end
    end
end