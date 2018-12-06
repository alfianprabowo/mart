class TransfersController < ApplicationController
  before_action :require_login
  def index
    @transfers = Transfer.page param_page
  end

  def new
    @stores = Store.select(:id, :name, :address).all
  end

  def create
    invoice = "TRF-" + Time.now.to_i.to_s
    items = transfer_items
    total_item = items.size
    to_store = params[:transfer][:store_id]

    transfer = Transfer.create invoice: invoice,
      total_items: total_item,
      from_store_id: current_user.store.id,
      date_created: Time.now,
      to_store_id: to_store

    items.each do |item|
      check_item = Item.find item[0]
      break if check_item.nil?
      a = TransferItem.create item_id: item[0], transfer_id: transfer.id, request_quantity: item[1], description: item[2]
      binding.pry
    end
    return redirect_to transfers_path
  end

  def confirmation
    return redirect_back_no_access_right unless params[:id].present?
    @retur = Transfer.find params[:id]
    return redirect_back_no_access_right unless @retur.date_picked.present?
    return redirect_to transfers_path unless @retur.present?
    @retur_items = TransferItem.where(retur_id: @retur.id)
  end

  def accept
    return redirect_back_no_access_right unless params[:id].present?
    retur = Transfer.find params[:id]
    return redirect_back_no_access_right unless @retur.date_picked.present?
    return redirect_back_no_access_right if retur.nil?
    items = retur_items
    items.each do |item|
      retur_item = TransferItem.find item[0]
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
    retur = Transfer.find params[:id]
    return redirect_back_no_access_right if retur.nil?
    # return redirect_back_no_access_right if retur.date_picked.present?
    retur.date_picked = Time.now
    retur.save!
    decrease_stock params[:id]
    return redirect_to transfers_path
  end

  def destroy
    return redirect_back_no_access_right unless params[:id].present?
    retur = Transfer.find params[:id]
    return redirect_back_no_access_right unless retur.present?
    return redirect_back_no_access_right if retur.date_approve.present?
    TransferItem.where(retur_id: params[:id]).destroy_all
    retur.destroy
    return redirect_to transfers_path
  end

  private
    def transfer_items
      items = []
      params[:transfer][:transfer_items].each do |item|
        items << item[1].values
      end
      items
    end

    def decrease_stock retur_id
      retur_items = TransferItem.where(retur_id: retur_id)
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
