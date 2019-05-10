class ZendeskGuideCategory < ActiveRecord::Base
    has_many :zendesk_guide_sections

    validates :name, presence: true
    validates :locale, presence: true
    
    def self.find_or_create_categories(options={})
        categories = options[:categories]
        category_objects = options[:category_objects]

        allowed_attributes = [
            :category_id,
            :name,
            :description,
            :locale,
            :source_locale,
            :url,
            :html_url,
            :outdated,
            :position,
            :category_created_at,
            :category_updated_at
        ]

        categories.each do |c|
            category_hash = c.clone

            category_hash[:category_id] = category_hash["id"]
            category_hash.delete("id")

            category_hash[:category_created_at] = category_hash["created_at"]
            category_hash.delete("created_at")

            category_hash[:category_updated_at] = category_hash["updated_at"]
            category_hash.delete("updated_at")

            category_hash.symbolize_keys!

            category_hash.each_key do |k|
                category_hash.delete(k) if !allowed_attributes.include?(k)
            end
            
            category = ZendeskGuideCategory.where(category_id: category_hash[:category_id]).first
            category.update(category_hash) if !category.nil?
            category = ZendeskGuideCategory.create(category_hash) if category.nil?
            
            category_objects << category
        end
    end

end