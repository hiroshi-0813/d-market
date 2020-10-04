# d-market DB設計

## users_table
|Column|Type|Options|
|------|----|-------|
|email|string|null: false, unique: true, index: true|
|password|string|null: false|
|nickname|string|null: false|
### Association
  has_many :comments
  has_many :favorites
  has_many :items
  has_many :user_evaluations
  has_many :seller_items, foreign_key: "seller_id", class_name: "items"
  has_many :buyer_items, foreign_key: "buyer_id", class_name: "items"
  has_one :profile, dependent: :destroy
  has_one :sending_destination, dependent: :destroy
  has_one :credit_card, dependent: :destroy

## profiles_table
|Column|Type|Options|
|------|----|-------|
|first_name|string|null: false|
|family_name|string|nuill: false|
|first_name_kana|string|null: false|
|family_name_kana|string|null: false|
|birth_year|date|null: false|
|birth_month|date|null: false|
|introductin|text|--|
|phone_number|string|unique:true|
|user|references|null:false, foreign_key: true|

### Association
  belongs_to :user

## items_table
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|introduction|text|null: false|
|price|integer|null: false|
|brand|references|foreign_key: true|
|item_condition_id(active_hash)|integer|null: false|
|postage_payer_id(active_hash)|integer|null: false|
|prefecture_id(active_hash)|integer|null: false|
|size_id|integer|null: false, foreign_key: true|
|postage_type_id(active_hash)|integer|null: false|
|category|references|null: false, foreign_key: true|
|trading_status|enum|null: false|
|seller|references|null: false, foreign_key: true|
|buyer|references|foreign_key: true|
|deal_closed_date|timestamp|------|
|preparation_day_id(active_hash)|integer|null: false|

### Association
  has_many :comments, dependent: :destroy
  has_many :favorites
  has_many :item_imgs, dependent: :destroy
  has_one :user_evaluation
  belongs_to :category
  belongs_to_active_hash :size
  belongs_to_active_hash :item_condition
  belongs_to_active_hash :postage_payer
  belongs_to_active_hash :preparation_day
  belongs_to_active_hash :postage_type
  belongs_to_active_hash :prefecture
  belongs_to :brand
  belongs_to :items_img
  belongs_to :seller, class_name: "User"
  belongs_to :buyer, class_name: "User"

## sending_destinations
|Column|Type|Options|
|------|----|-------|
|destination_first_name|string|null: false|
|destination_family_name|string|null: false|
|destination_first_name_kana|string|null: false|
|destnation_family_name_kana|string|null: false|
|post_code|integer(7)|null: false|
|prefercture_code|integer|null: false|
|city|string|null: false|
|house_number|string|null: false|
|building_name|string|------|
|user|references|null: false, foreign_key: true|
### Associations
  belongs_to :user

## user_evaluations
|Column|Type|Options|
|------|----|-------|
|review|text|null: false|
|user|references|null: false, foreign_key: true|
|item|references|null: false, foreign_key: true|
|evalution_id(active_hash)|integer|null: false|
### Associations
  belongs_to_active_hash :evaluation
  belongs_to :user
  belongs_to :item

## categories
|Column|Type|Options|
|name|string|null: false|
|ancestry|string|null: false|
### Associations
  has_many :items

## brands
|Column|Type|Options|
|name|stirng|null: false|
### Associations
  has_many :items

## items_imgs
|Column|Type|Options|
|url|string|null: false|
|item|references|null: false, foreign_key: true|
### Associations
  belongs_to :item

## favorites
|Column|Type|Options|
|user|references|null: false, foreign_key: true|
|item|references|null: false, foreign_key: true|
### Associations
  belongs_to :user
  belongs_to :item

## comments
|Column|Type|Options|
|comment|text|null: false|
|user|references|null: false, foreign_key: true|
|item|references|null: false, foreign_key: true|
|created_at|timestamp|null: false|
### Association
  belongs_to :user
  belongs_to :item

## credit_cards
|Column|Type|Options|
|user_id|integer|null: false, foreign_key: true|
|customer_id|string|null: false|
|card_id|string|null: false|
### Associations
  belongs_to:user