class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  validates :user_id, :name, :description, :price, :condition_id, :wait, :postage, :category_id, :brand_id, :prefecture_id, presence: true
  validates :images, presence: true
  validates :price, :numericality => { :greater_than => 299 }
  validates :price, :numericality => { :less_than => 9999999 }
  
  belongs_to :user, optional: true
  has_many :comments
  belongs_to :category
  belongs_to :brand

  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true

  belongs_to_active_hash :prefecture
  belongs_to_active_hash :condition
end
