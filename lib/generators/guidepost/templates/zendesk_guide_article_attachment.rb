class ZendeskGuideArticleAttachment < ActiveRecord::Base
    belongs_to :zendesk_guide_article

    def self.find_or_create_article_attachments(options={})
        article_attachments = options[:article_attachments]
        article_objects = options[:article_objects]
        allowed_attributes = [
            :article_id,
            :article_attachment_id,
            :url,
            :file_name,
            :content_url,
            :size,
            :inline,
            :article_attachment_created_at,
            :article_attachment_updated_at
        ]

        article_attachments.each do |aa|
            article_attachment_hash = aa.clone

            article_attachment_hash[:article_attachment_id] = article_attachment_hash["id"]
            article_attachment_hash.delete("id")

            article_attachment_hash[:article_attachment_created_at] = article_attachment_hash["created_at"]
            article_attachment_hash.delete("created_at")

            article_attachment_hash[:article_attachment_updated_at] = article_attachment_hash["updated_at"]
            article_attachment_hash.delete("updated_at")

            article_attachment_hash.symbolize_keys!

            article_attachment = ZendeskGuideArticleAttachment.where(article_attachment_id: article_attachment_hash[:article_attachment_id]).first
            article_attachment.update(article_attachment_hash) if !article_attachment.nil?
            article_attachment = ZendeskGuideArticleAttachment.create(article_attachment_hash) if article_attachment.nil?
            
            article_objects.each do |a|
                is_correct_article = (article_attachment.article_id == a.article_id)
                if is_correct_article
                    article_attachment.zendesk_guide_article = co
                    article_attachment.save
                    break
                end
            end
        end
    end
end