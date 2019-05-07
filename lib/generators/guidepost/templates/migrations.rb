class CreateKnowledgeBaseGuideModels < ActiveRecord::Migration
    def change
        create_table :knowledge_base_guide_category do |t|
            t.integer :category_id
            t.string :name, null: false, default: "Holberton"
            t.string :description
            t.string :locale, null: false, default: "en-us"
            t.string :source_locale
            t.string :url
            t.string :html_url
            t.boolean :outdated
            t.integer :position
            t.timestamp :category_created_at
            t.timestamp :category_updated_at
        end

        create_table :knowledge_base_guide_section do |t|
            t.integer :category_id
            t.integer :section_id
            t.string :name, null: false, default: "Holberton"
            t.string :description
            t.string :locale, null: false, default: "en-us"
            t.string :source_locale
            t.string :url
            t.string :html_url
            t.boolean :outdated
            t.integer :position
            t.timestamp :section_created_at
            t.timestamp :section_updated_at
        end

        create_table :knowledge_base_guide_article do |t|
            t.integer :section_id
            t.integer :article_id
            t.string :url
            t.string :html_url
            t.string :title, null: false, default: "FAQ"
            t.string :body
            t.string :locale, null: false, default: "en-us"
            t.string :source_locale
            t.integer :author_id
            t.boolean :comments_disabled
            t.string :outdated_locales, array: true
            t.string :label_names, array: true
            t.boolean :draft
            t.boolean :promoted
            t.integer :position
            t.integer :vote_sum
            t.integer :vote_count
            t.integer :user_segment_id
            t.integer :permission_group_id
            t.timestamp :article_created_at
            t.timestamp :article_edited_at
            t.timestamp :article_updated_at
        end
    end
end