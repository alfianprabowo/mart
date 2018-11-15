class ItemsController < ApplicationController
  before_action :require_login
  def index
    @items = Item.page param_page
  end

  def new
    @item_cats = ItemCat.all
  end

  def create
    item = Item.new item_params
    return redirect_to new_item_path if item.invalid?

    item.save!
    insert_into_all_store item.id
    return redirect_to items_path

  end

  def edit
    return redirect_back_no_access_right unless params[:id].present?
    @item = Item.find_by_id params[:id]
    return redirect_to items_path unless @item.present?
    @item_cats = ItemCat.all
  end

  def update
    return redirect_back_no_access_right unless params[:id].present?
    item = Item.find_by_id params[:id]
    item.assign_attributes item_params
    item.save! if item.changed?
    return redirect_to items_path
  end

  private
    def item_params
      params.require(:item).permit(
        :name, :code, :item_cat_id, :buy, :sell
      )
    end

    def param_page
      params[:page]
    end

    def insert_into_all_store item_id
      stores = Store.all.pluck(:id)
      stores.each do |store_id|
        StoreItem.create item_id: item_id, store_id: store_id
      end
    end
end
