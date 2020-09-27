class ItemsController < ApplicationController
  def index
    @item = item.includes(:items_imgs)
  end
end
