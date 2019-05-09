class ZendeskGuidePermissionGroup < ActiveRecord::Base
    has_many :zendesk_guide_articles

    def self.find_or_create_permission_groups(options={})
        permission_groups = options[:permission_groups]
        permission_group_objects = options[:permission_group_objects]

        permission_groups.each do |p|
            permission_group_hash = p.clone

            permission_group_hash[:permission_group_id] = permission_group_hash["id"]
            permission_group_hash.delete("id")

            permission_group_hash[:permission_group_created_at] = permission_group_hash["created_at"]
            permission_group_hash.delete("created_at")

            permission_group_hash[:permission_group_updated_at] = permission_group_hash["updated_at"]
            permission_group_hash.delete("updated_at")

            permission_group_hash.symbolize_keys!

            permission_group = ZendeskGuidePermissionGroup.where(permission_group_hash).first
            permission_group.update(permission_group_hash) if !permission_group.nil?
            permission_group = ZendeskGuidePermissionGroup.create(permission_group_hash) if permission_group.nil?

            permission_group_objects << permission_group
        end
    end
end