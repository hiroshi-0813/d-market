class ItemsImg < ApplicationRecord

  belongs_to :item

  mount_uploader :url, ImageUploader

end
