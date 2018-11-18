class ReturnsController < ApplicationController
  before_action :require_login
  def index
    @returns = Return.page param_page
  end

  def new

  end

  def create
    invoice = "RE-" + Time.now.to_i.to_s
    items = return_items
    total_item = items.size

    rturn = Return.create invoice: invoice, total_items: total_item, store_id: current_user.store.id, date_created: Time.now

    items.each do |item|
      ReturnItem.create item_id: item[0], return_id: rturn.id, quantity: item[1], description: item[2]
    end
    return redirect_to returns_path
  end

  private
    def return_items
      items = []
      params[:return][:return_items].each do |item|
        items << item[1].values
      end
      items
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
