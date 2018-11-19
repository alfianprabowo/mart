class RetursController < ApplicationController
  before_action :require_login
  def index
    @returs = Retur.page param_page
  end

  def new

  end

  def create
    invoice = "RE-" + Time.now.to_i.to_s
    items = retur_items
    total_item = items.size

    retur = Retur.create invoice: invoice, total_items: total_item, store_id: current_user.store.id, date_created: Time.now

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
