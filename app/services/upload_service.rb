require 'aws-sdk-s3'

class UploadService
  class << self
    def s3_presigned_url(store_path)
      return store_path unless s3_resource

      s3_resource.object(store_path).presigned_url(:get, expires_in: 1.weeks.to_i)
    end

    def s3_presigned_upload_url(filepath)
      return filepath unless s3_resource

      s3_resource.object(filepath).presigned_url(
        :put,
        acl: 'private',
        expires_in: 1.weeks.to_i
      )
    end

    def s3_resource
      access_key_id = ENV['AWS_ACCESS_KEY_ID']
      access_key = ENV['AWS_SECRET_ACCESS_KEY']
      region = ENV['AWS_REGION']
      bucket = ENV['S3_BUCKET_NAME']

      return if access_key_id.blank? || access_key.blank? || region.blank? || bucket.blank?

      @s3_resource ||= Aws::S3::Resource.new(
        access_key_id: access_key_id,
        secret_access_key: access_key,
        region: region,
        force_path_style: true
      ).bucket(bucket) 
    end
  end
end
