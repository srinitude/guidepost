class ZendeskGuideArticle < ActiveRecord::Base
    belongs_to :zendesk_guide_section
    belongs_to :zendesk_guide_user_segment
    belongs_to :zendesk_guide_permission_group

    has_many :zendesk_guide_article_attachments

    validates :title, presence: true
    validates :locale, presence: true
end