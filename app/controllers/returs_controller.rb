class RetursController < ApplicationController
  before_action :require_login
  def index
    @returs = Retur.page param_page
    if params[:search].present?
      search = params[:search].downcase
      @search = search
      search_arr = search.split(":")
      if search_arr.size > 2
        return redirect_back_no_access_right
      elsif search_arr.size == 2
        store = Store.where('lower(name) like ?', "%"+search_arr[1].downcase+"%").pluck(:id)
        supplier = Supplier.where('lower(pic) like ?', "%"+search_arr[1].downcase+"%").pluck(:id)
          if search_arr[0]== "to" && supplier.present?
            @returs = @returs.where(supplier_id: supplier)
          elsif search_arr[0]== "from" && store.present?
            @returs = @returs.where(store_id: store)
          else
            @returs = @returs.where("invoice like ?", "%"+ search_arr[1]+"%")
          end
      else
        @returs = @returs.where("invoice like ?", "%"+ search+"%")
      end
    end
  end

  def new
    @suppliers = Supplier.select(:id, :pic, :address).order("supplier_type DESC").all
  end

  def create
    invoice = "RE-" + Time.now.to_i.to_s
    items = retur_items
    total_item = items.size
    address_to = params[:retur][:supplier_id]

    retur = Retur.create invoice: invoice,
      total_items: total_item,
      store_id: current_user.store.id,
      date_created: Time.now,
      supplier_id: address_to

    items.each do |item|
      item = Item.find item[0]
      break if item.nil?
      ReturItem.create item_id: item[0], retur_id: retur.id, quantity: item[1], description: item[2]
    end
    return redirect_to returs_path
  end

  def confirmation
    return redirect_back_no_access_right unless params[:id].present?
    @retur = Retur.find params[:id]
    return redirect_back_no_access_right unless @retur.date_picked.present?
    return redirect_to returs_path unless @retur.present?
    @retur_items = ReturItem.where(retur_id: @retur.id)
  end

  def accept
    return redirect_back_no_access_right unless params[:id].present?
    retur = Retur.find params[:id]
    return redirect_back_no_access_right unless @retur.date_picked.present?
    return redirect_back_no_access_right if retur.nil?
    items = retur_items
    items.each do |item|
      retur_item = ReturItem.find item[0]
      break if retur_item.nil?
      break if retur_item.quantity < item[1].to_i
      retur_item.accept_item = item[1]
      retur_item.save!
    end
    retur.date_approve = Time.now
    retur.save!
    return redirect_to retur_items_path(id: params[:id])
  end

  def picked
    return redirect_back_no_access_right unless params[:id].present?
    retur = Retur.find params[:id]
    return redirect_back_no_access_right if retur.nil?
    # return redirect_back_no_access_right if retur.date_picked.present?
    retur.date_picked = Time.now
    retur.save!
    decrease_stock params[:id]
    return redirect_to returs_path
  end

  def destroy
    return redirect_back_no_access_right unless params[:id].present?
    retur = Retur.find params[:id]
    return redirect_back_no_access_right unless retur.present?
    return redirect_back_no_access_right if retur.date_approve.present?
    ReturItem.where(retur_id: params[:id]).destroy_all
    retur.destroy
    return redirect_to returs_path
  end

  private
    def retur_items
      items = []
      params[:retur][:retur_items].each do |item|
        items << item[1].values
      end
      items
    end

    def decrease_stock retur_id
      retur_items = ReturItem.where(retur_id: retur_id)
      retur_items.each do |retur_item|
        confirmation = retur_item.accept_item
        item = StoreItem.find_by(item_id: retur_item.item.id, store_id: current_user.store.id)
        new_stock = item.stock.to_i - confirmation.to_i
        item.stock = new_stock
        item.save!
      end
    end

    def param_page
      params[:page]
    end

end
