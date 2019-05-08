class ZendeskGuideCategory < ActiveRecord::Base
    has_many :zendesk_guide_sections

    validates :name, presence: true
    validates :locale, presence: true
end