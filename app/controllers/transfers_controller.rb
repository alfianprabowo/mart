class TransfersController < ApplicationController
  before_action :require_login
  def index
    @transfers = Transfer.page param_page
    if params[:search].present?
      search = params[:search].downcase
      @search = search
      search_arr = search.split(":")
      if search_arr.size > 2
        return redirect_back_no_access_right
      elsif search_arr.size == 2
        store = Store.where('lower(name) like ?', "%"+search_arr[1].downcase+"%").pluck(:id)
        if store.present?
          if search_arr[0]== "to"
            @transfers = @transfers.where(to_store_id: store)
          elsif search_arr[1]== "from"
            @transfers = @transfers.where(from_store_id: store)
          else
            @transfers = @transfers.where("invoice like ?", "%"+ search_arr[1]+"%")
          end
        end
      else
        @transfers = @transfers.where("invoice like ?", "%"+ search+"%")
      end
    end
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
      next if check_item.nil?
      qty = item[1].to_i
      next if qty < 1
      TransferItem.create item_id: item[0], transfer_id: transfer.id, request_quantity: qty, description: item[2]
    end
    return redirect_to transfers_path
  end

  def confirmation
    return redirect_back_no_access_right unless params[:id].present?
    @transfer = Transfer.find params[:id]
    return redirect_to transfers_path unless @transfer.present?
    return redirect_to transfers_path if @transfer.date_approve.present?
    @transfer_items = TransferItem.where(transfer_id: @transfer.id)
  end

  def accept
    return redirect_back_no_access_right unless params[:id].present?
    transfer = Transfer.find params[:id]
    return redirect back_no_access_right unless transfer.present?
    return redirect_back_no_access_right if transfer.date_confirm.present? || transfer.date_picked.present?
    transfer.date_approve = Time.now
    transfer.save!
    return redirect_to transfer_path id: params[:id]
  end

  def picked
    return redirect_back_no_access_right unless params[:id].present?
    @transfer = Transfer.find params[:id]
    return redirect_back_no_access_right unless @transfer.present?
    return redirect_back_no_access_right if @transfer.date_approve.nil? || @transfer.date_picked.present?
    @transfer_items = TransferItem.where(transfer_id: @transfer.id)
  end

  def sent
    return redirect_back_no_access_right unless params[:id].present?
    transfer = Transfer.find params[:id]
    return redirect_back_no_access_right if transfer.nil?
    return redirect_back_no_access_right if transfer.date_picked.present? || transfer.date_picked.present?
    transfer.date_picked = Time.now
    transfer.save!
    decrease_stock
    sent_items params[:id]
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

    def sent_items transfer_id
      transfer_items.each do |item|
        transfer_item = TransferItem.find item[2]
        qty = item[1].to_i
        next if qty < 1
        if transfer_item.request_quantity < qty
          qty = transfer_item.request_quantity
        end
        transfer_item.sent_quantity = qty
        transfer_item.save!
      end
    end

    def decrease_stock
      transfer_items.each do |item|
        sent_total_item = item[1]
        store_item = StoreItem.find_by(item_id: item[0], store_id: current_user.store.id)
        new_stock = store_item.stock.to_i - sent_total_item.to_i
        store_item.stock = new_stock
        store_item.save!
      end
    end

    def param_page
      params[:page]
    end

end
