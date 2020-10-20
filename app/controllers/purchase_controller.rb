class PurchaseController < ApplicationController
  before_action :set_category
  before_action :set_item,       only: [:index, :pay]
  before_action :set_card,       only: [:index, :pay]


  def index
    @city = Prefecture.find(current_user.address.city).name
    @credit_card = CreditCard.where(user_id: current_user.id).first
    if @credit_card.blank?
      redirect_to new_credit_card_path
    else
      Payjp.api_key = Rails.application.credentials.PAYJP[:PAYJP_ACCESS_KEY]
      #保管した顧客IDでpayjpから情報取得
      customer = Payjp::Customer.retrieve(@credit_card.customer_id)
      #保管したカードIDでpayjpから情報取得、カード情報表示のためインスタンス変数に代入
      @default_card_information = customer.cards.retrieve(@credit_card.credit_card_id)
    end
  end

  def pay
    Payjp.api_key = Rails.application.credentials.PAYJP[:PAYJP_ACCESS_KEY]
    Payjp::Charge.create(
      amount: @item.price,
      customer: @credit_card.customer_id, #顧客ID
      currency: 'jpy', #日本円
    )
    @item.buyer_id = 0
    @item.buyer_id = @item.buyer_id + current_user.id
    if @item.save
      redirect_to action: 'done' #完了画面に移動
    else
      redirect_to purchase_index_path
    end
  end

  private
  def set_item
     @item = Item.find(params[:id])
    #仕上がり次第、paramsに変更
  end

  def set_card
    @credit_card = CreditCard.where(user_id: current_user.id).first
  end

  def set_category
    @category_parent_array = []
  end

end
