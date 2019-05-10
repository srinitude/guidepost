class ZendeskGuideUserSegment < ActiveRecord::Base
    has_many :zendesk_guide_articles

    def self.find_or_create_user_segments(options={})
        user_segments = options[:user_segments]
        user_segment_objects = options[:user_segment_objects]
        allowed_attributes = [
            :user_segment_id,
            :name,
            :user_type,
            :group_ids,
            :organization_ids,
            :tags,
            :user_segment_created_at,
            :user_segment_updated_at
        ]

        user_segments.each do |s|
            user_segment_hash = s.clone

            user_segment_hash[:user_segment_id] = user_segment_hash["id"]
            user_segment_hash.delete("id")

            user_segment_hash[:user_segment_created_at] = user_segment_hash["created_at"]
            user_segment_hash.delete("created_at")

            user_segment_hash[:user_segment_updated_at] = user_segment_hash["updated_at"]
            user_segment_hash.delete("updated_at")

            user_segment_hash.symbolize_keys!

            user_segment_hash.each_key do |k|
                user_segment_hash.delete(k) if !allowed_attributes.include?(k)
            end

            user_segment = ZendeskGuideUserSegment.where(user_segment_id: user_segment_hash[:user_segment_id]).first
            user_segment.update(user_segment_hash) if !user_segment.nil?
            user_segment = ZendeskGuideUserSegment.create(user_segment_hash) if user_segment.nil?

            user_segment_objects << user_segment
        end
    end
end