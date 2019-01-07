class TransactionItemsController < ApplicationController
  before_action :require_login
  def index
    return redirect_back_no_access_right unless params[:id].present?
    @transaction_items = TransactionItem.page param_page
    @transaction_items = @transaction_items.where(transaction_id: params[:id])
    @item = Item.page param_page
  end
  
  private
    def param_page
      params[:page]
    end

    # def item_value
#       array = []
#       params[:transaction][:transaction_items].each do |item|
#         array << item[1].values
#       end
#       array
#     end
  
end