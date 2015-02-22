class Receipt < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  belongs_to :report
end
