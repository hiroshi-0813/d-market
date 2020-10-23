class ItemsController < ApplicationController


  def index
    @item = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
    @item.items_img.new
    @item.build_brand
  end

  def create
    @item = Item.new(item_params)
    if @item.save!
      redirect_to root_path, notice: '出品しました'
    else
      redirect_to new_item_path
    end
  end



  private
  def item_params
    params.require(:item).permit(
      :name,
      :price,
      :introduction,
      # :category,
      :item_condition_id,
      :postage_payer_id,
      :prefecture_id,
      :postage_type_id,
      :preparation_day_id,
      :seller_id,
      :buyer_id,
      :deal_closed_date, 
      brand_attributes: [:id, :name],
      items_img_attributes: [:url, :id]
    ).merge(seller_id: current_user.id)
  end
end