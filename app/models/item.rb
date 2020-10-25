class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :postage_type
  belongs_to_active_hash :preparation_day
  belongs_to_active_hash :postage_payer
  belongs_to_active_hash :item_condition

  belongs_to :user, optional: true
  belongs_to :brand, optional: true
  belongs_to :seller, class_name: "User", optional: true
  belongs_to :buyer, class_name: "User", optional: true
  has_many :items_imgs, dependent: :destroy
  accepts_nested_attributes_for :items_imgs, allow_destroy: true
  accepts_nested_attributes_for :brand

  validates :name, presence: true
  validates :price, presence: true
  validates :introduction, presence: true
  # validates :category, presence:true
  validates :items_img, presence: true
  validates :prefecture, presence: true
  validates :postage_type, presence: true
  validates :preparation_day, presence: true
  validates :postage_payer, presence: true
  validates :item_condition, presence: true
end
