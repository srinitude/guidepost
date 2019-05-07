class ZendeskGuideCategory < ActiveRecord::Base
    has_many :zendesk_guide_sections

    validates :name, presence: true
    validates :locale, presence: true

    validates :url, format: { with: /https:\/\/(\S+).zendesk.com\/api\/v2\/help_center\/(\S+)\/categories\/(\S+).json/, message: "Only allows for a valid Zendesk JSON endpoint" }
end