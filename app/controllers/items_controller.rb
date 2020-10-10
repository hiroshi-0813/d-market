class ItemsController < ApplicationController


  def index
    @item = Item.includes(:items_img).order('created_at DESC')
  end

  def new
    @item = Item.new
    @item.items_img.new
    @item.build_brand
  end

  def create
    binding.pry
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path, notice: '出品しました'
    else
      redirect_to new_item_path
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    if @item.update(item_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    
  end

  private
  def item_params
    params.require(:item).permit(
      :name,
      :price,
      :introduction,
      # :category,
      brand_id_attributes: [:id, :name],
      item_condition_id: [:id, :item_condition],
      postage_payer_id: [:id, :postage_payer],
      prefecture_id: [:id, :name],
      postage_type_id: [:id, :postage_type],
      preparation_day_id: [:id, :preparation_day],
      # :trading_status,
      seller_id: [:id],
      buyer_id: [:id],
      # :deal_closed_date, 
      items_img_attributes: [:url, :id])
      .merge(seller_id: current_user)
  end

end
