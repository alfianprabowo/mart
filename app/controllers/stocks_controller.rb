class StocksController < ApplicationController
  before_action :require_login
  def index
    @inventories = StoreItem.page param_page
    store_id = current_user.store.id
    @inventories = @inventories.where(store_id: store_id)
    if params[:search].present?
      @search = params[:search].downcase
      search = "%"+@search+"%"
      items = Item.where('lower(name) like ? OR code like ?', search, search).pluck(:id)
      @inventories = @inventories.where(item_id: items)
    end

  end

  def edit
    return redirect_back_no_access_right unless params[:id].present?
    @stock = StoreItem.find_by_id params[:id]
    return redirect_to stocks_path unless @stock.present?
    @item = @stock.item
    @item_cats = ItemCat.all
  end

  def update
    return redirect_back_no_access_right unless params[:id].present?
    item = StoreItem.find_by_id params[:id]
    item.assign_attributes stock_params
    item.save! if item.changed?
    return redirect_to stocks_path
  end

  private
    def stock_params
      {
        stock: params[:item][:stock][:stock]
      }
    end

    def param_page
      params[:page]
    end
end
