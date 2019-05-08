class ZendeskGuideSection < ActiveRecord::Base
    belongs_to :zendesk_guide_category
    has_many :zendesk_guide_articles

    validates :name, presence: true
    validates :locale, presence: true
end