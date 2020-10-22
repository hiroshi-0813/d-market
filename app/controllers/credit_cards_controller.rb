class CreditCardsController < ApplicationController
  before_action :set_card, only: [:destroy, :show]
  before_action :set_category
  
  def index
  end

  def new # カードの登録画面。送信ボタンを押すとcreateアクションへ。
    credit_card = CreditCard.where(user_id: current_user.id)
    redirect_to credit_cards_path if credit_card.present?
  end

  def create #PayjpとCardのデータベースを作成
    Payjp.api_key = Rails.application.credentials.PAYJP[:PAYJP_ACCESS_KEY]

    if params['payjp-token'].blank?
      redirect_to new_credit_card_path
    else
      # トークンが正常に発行されていたら、顧客情報をPAY.JPに登録。
      customer = Payjp::Customer.create(
        description: 'test', # 無くてもOK。PAY.JPの顧客情報に表示する概要です。
        card: params['payjp-token'], # 直前のnewアクションで発行され、送られてくるトークンをここで顧客に紐付けて永久保存します。
        #metadata: {user_id: current_user.id} # 無くてもOK。
      )
      @credit_card = CreditCard.new(user_id: current_user.id, customer_id: customer.id, credit_card_id: customer.default_card)
      if @credit_card.save
        redirect_to credit_cards_path
      else
        redirect_to new_credit_card_path
      end
    end
  end

  def show #Cardのデータpayjpに送り情報を取り出します
    if @credit_card.blank?
      redirect_to action: "new" 
    else
      Payjp.api_key = Rails.application.credentials.PAYJP[:PAYJP_ACCESS_KEY]
      customer = Payjp::Customer.retrieve(@credit_card.customer_id)
      @default_card_information = customer.cards.retrieve(@credit_card.credit_card_id)
    end
  end

  def destroy #PayjpとCardデータベースを削除します
    unless @credit_card.blank?
      Payjp.api_key =  Rails.application.credentials.PAYJP[:PAYJP_ACCESS_KEY]
      customer = Payjp::Customer.retrieve(@credit_card.customer_id)
      customer.delete
      @credit_card.delete
    end
  end

  private

  def set_card
    @credit_card = CreditCard.where(user_id: current_user.id).first
  end

  def set_category
    @category_parent_array = []
  end
end
