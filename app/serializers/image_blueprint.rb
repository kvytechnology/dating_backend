class ImageBlueprint < Blueprinter::Base
  identifier :id

  field :url do |image, _options|
    UploadService.s3_presigned_url(image.store_path)
  end
end
