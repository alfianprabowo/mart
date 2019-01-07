class TransactionsController < ApplicationController
  before_action :require_login
  def index
    @transactions = Transaction.page param_page
    # if params[:search].present?
#       search = params[:search].downcase
#       @search = search
#       search_arr = search.split(":")
#       if search_arr.size > 2
#         return redirect_back_no_access_right
#       elsif search_arr.size == 2
#         store = Store.where('lower(name) like ?', "%"+search_arr[1].downcase+"%").pluck(:id)
#         supplier = Supplier.where('lower(pic) like ?', "%"+search_arr[1].downcase+"%").pluck(:id)
#           if search_arr[0]== "to" && supplier.present?
#             @transaction = @transactions.where(supplier_id: supplier)
#           elsif search_arr[0]== "from" && store.present?
#             @returs = @returs.where(store_id: store)
#           else
#             @returs = @returs.where("invoice like ?", "%"+ search_arr[1]+"%")
#           end
#       else
#         @returs = @returs.where("invoice like ?", "%"+ search+"%")
#       end
#     end
  end
  
  def new
    @stores = Store.select(:id, :name, :address).all
  end

  def create
    invoice = "TRX-" + Time.now.to_i.to_s
    items = transaction_items
    total_item = items.size
    to_store = params[:transaction][:store_id]

      transaction = Transaction.create invoice: invoice,
      total_items: total_item,
      from_store_id: current_user.store.id,
      date_created: Time.now,
      to_store_id: to_store

    items.each do |item|
      check_item = Item.find item[0]
      next if check_item.nil?
      qty = item[1].to_i
      next if qty < 1
      TransactionItem.create item_id: item[0], transaction_id: transaction.id, request_quantity: qty, description: item[2]
    end
    return redirect_to transfers_path
  end
  
  private
    def transaction_items
      items = []
      params[:transaction][:transaction_items].each do |item|
        items << item[1].values
      end
      items
    end

    def decrease_stock transaction_id
      transaction_items = TransactionItem.where(transaction_id: transaction_id)
      transaction_items.each do |transaction_item|
        # confirmation = retur_item.accept_item
        item = StoreItem.find_by(item_id: transaction_item.item.id, store_id: current_user.store.id)
        new_stock = item.stock.to_i - confirmation.to_i
        item.stock = new_stock
        item.save!
      end
    end

    def param_page
      params[:page]
    end
end
