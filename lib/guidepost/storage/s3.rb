module Guidepost
    module Storage
        class S3
            attr_accessor :project_name
            
            def initialize(options={})
                @project_name = options[:project_name]

                raise "Guidepost::Storage::S3 initializer is missing a project_name" if @project_name.nil?

                @project_name.upcase!

                @s3_client = Aws::S3::Resource.new(
                    credentials: Aws::Credentials.new(ENV["#{@project_name}_GUIDEPOST_AWS_ACCESS_KEY_ID"], ENV["#{@project_name}_GUIDEPOST_AWS_SECRET_ACCESS_KEY"]),
                    region: ENV["#{@project_name}_GUIDEPOST_AWS_REGION"] || "us-east-1"
                )
            end

            def upload_file(options={})
                path = options.fetch(:path, nil)
                string_content = options.fetch(:string_content, "")
                acl = options.fetch(:acl, "private")
                metadata = options.fetch(:metadata, nil)

                bucket_name = ENV["#{self.project_name}_GUIDEPOST_S3_BUCKET_NAME"]
                storage_class = ENV["#{self.project_name}_GUIDEPOST_S3_STORAGE_CLASS"] || "STANDARD_IA"

                return false if path.nil?
                begin
                    obj = @s3_client.bucket(bucket_name).object(path)
                    result = obj.put({
                        body: string_content,
                        acl: acl,
                        storage_class: storage_class,
                        metadata: metadata,
                    }) 
                rescue Seahorse::Client::NetworkingError => e
                    raise e if !Rails.env.test?
                    return true
                end
                return !result.nil?
            end
        end
    end 
end