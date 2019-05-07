class ZendeskGuidePermissionGroup < ActiveRecord::Base
    has_many :zendesk_guide_articles
end