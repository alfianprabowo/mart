class RetursController < ApplicationController
  before_action :require_login
  def index
    @returs = Retur.page param_page
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
      ReturItem.create item_id: item[0], retur_id: retur.id, quantity: item[1], description: item[2]
    end
    return redirect_to returs_path
  end

  def confirmation
    return redirect_back_no_access_right unless params[:id].present?
    @retur = Retur.find params[:id]
    return redirect_to returs_path unless @retur.present?
    @retur_items = ReturItem.where(retur_id: @retur.id)
  end

  def accept
    return redirect_back_no_access_right unless params[:id].present?
    retur = Retur.find params[:id]
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
    retur.date_picked = Time.now
    retur.save!
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

    def param_page
      params[:page]
    end

end
