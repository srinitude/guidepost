class ZendeskGuideSection < ActiveRecord::Base
    belongs_to :zendesk_guide_category
    has_many :zendesk_guide_articles

    validates :name, presence: true
    validates :locale, presence: true

    def self.find_or_create_sections(options={})
        sections = options[:sections]
        section_objects = options[:section_objects]
        category_objects = options[:category_objects]

        sections.each do |s|
            section_hash = s.clone

            section_hash[:section_id] = section_hash["id"]
            section_hash.delete("id")

            section_hash[:section_created_at] = section_hash["created_at"]
            section_hash.delete("created_at")

            section_hash[:section_updated_at] = section_hash["updated_at"]
            section_hash.delete("updated_at")

            section_hash.symbolize_keys!

            section = ZendeskGuideSection.where(section_hash).first
            section.update(section_hash) if !section.nil?
            section = ZendeskGuideSection.create(section_hash) if section.nil?
            
            category_objects.each do |co|
                is_correct_category = (section.category_id == co.category_id)
                if is_correct_category
                    section.zendesk_guide_category = co
                    section.save
                    break
                end
            end

            section_objects << section
        end
    end
end