class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :credit_card
  has_many :items
  has_one :address

  # バリデーション
  validates :nickname, :family_name, :first_name, :family_name_kana, :first_name_kana, :birth_date, :phone_number, :gender, presence: true

  # 文字の形式制限
  validates :family_name, :first_name, format: { with: /\A[ぁ-んァ-ン一-龥]/,
    message: "全角文字のみが使えます" }
  validates :family_name_kana,:first_name_kana, format: { with: /\A[ァ-ヶー－]+\z/,
    message: "全角カナのみが使えます" }


end
