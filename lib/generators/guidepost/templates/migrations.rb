class CreateZendeskGuideModels < ActiveRecord::Migration
    def change
        create_table :zendesk_guide_categories do |t|
            t.integer :category_id, limit: 8
            t.string :name, null: false, default: "General"
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

        create_table :zendesk_guide_sections do |t|
            t.references :zendesk_guide_category, foreign_key: true
            t.integer :category_id, limit: 8
            t.integer :section_id, limit: 8
            t.string :name, null: false, default: "General"
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

        create_table :zendesk_guide_user_segments do |t|
            t.integer :user_segment_id, limit: 8
            t.string :name
            t.string :user_type
            t.integer :group_ids, array: true, default: [], limit: 8
            t.integer :organization_ids, array: true, default: [], limit: 8
            t.string :tags, array: true, default: []
            t.timestamp :user_segment_created_at
            t.timestamp :user_segment_updated_at
        end

        create_table :zendesk_guide_permission_groups do |t|
            t.integer :permission_group_id, limit: 8
            t.string :name
            t.integer :edit, array: true, default: [], limit: 8
            t.integer :publish, array: true, default: [], limit: 8
            t.timestamp :permission_group_created_at
            t.timestamp :permission_group_updated_at
            t.boolean :built_in
        end

        create_table :zendesk_guide_articles do |t|
            t.references :zendesk_guide_section, foreign_key: true
            t.integer :section_id, limit: 8
            t.integer :article_id, limit: 8
            t.string :url
            t.string :html_url
            t.string :title, null: false, default: "FAQ"
            t.string :body
            t.string :locale, null: false, default: "en-us"
            t.string :source_locale
            t.integer :author_id, limit: 8
            t.boolean :comments_disabled, default: false
            t.string :outdated_locales, array: true
            t.string :label_names, array: true, default: []
            t.boolean :draft, default: false
            t.boolean :promoted, default: false
            t.integer :position, default: 0
            t.integer :vote_sum
            t.integer :vote_count
            t.integer :user_segment_id, limit: 8
            t.references :zendesk_guide_user_segment, foreign_key: true
            t.integer :permission_group_id, limit: 8
            t.references :zendesk_guide_permission_group, foreign_key: true
            t.timestamp :article_created_at
            t.timestamp :article_edited_at
            t.timestamp :article_updated_at
        end

        create_table :zendesk_guide_article_attachments do |t|
            t.references :zendesk_guide_article, foreign_key: true
            t.integer :article_id, limit: 8
            t.integer :article_attachment_id, limit: 8
            t.string :url
            t.string :file_name
            t.string :content_url
            t.integer :size, limit: 8
            t.boolean :inline, default: false
            t.timestamp :article_attachment_created_at
            t.timestamp :article_attachment_updated_at
        end
    end
end