class ZendeskGuideSection < ActiveRecord::Base
    belongs_to :zendesk_guide_category
    has_many :zendesk_guide_articles

    validates :name, presence: true
    validates :locale, presence: true

    validates :url, format: { with: /https:\/\/(\S+).zendesk.com\/api\/v2\/help_center\/(\S+)\/sections\/(\S+).json/, message: "Only allows for a valid Zendesk JSON endpoint" }
end