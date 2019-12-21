class ImagesController < ApplicationController
  before_action :authenticate_user

  def upload_url
    store_paths = params[:file_names]&.split(',')&.map do |file_name|
      file_name = uploader.file_name(file_name)
      store_path = File.join(uploader.store_dir(current_user.id), file_name)

      {
        file_name: file_name,
        upload_url: UploadService.s3_presigned_upload_url(store_path)
      }
    end

    render json: {data: store_paths}
  end

  def create
    store_paths = params[:file_names]&.split(',')&.map do |file_name|
      store_path = File.join(uploader.store_dir(current_user.id), file_name)

      image = Image.create(user_id: current_user.id, file_name: file_name, store_path: store_path)

      {
        url: UploadService.s3_presigned_url(store_path)
      }
    end

    render json: {data: store_paths}
  end

  def uploader
    @uploader ||= ImageUploader.new
  end
end
