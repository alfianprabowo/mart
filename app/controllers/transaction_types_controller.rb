class TransactionTypesController < ApplicationController
  before_action :require_login
  def index
    @transaction_types = TransactionType.page param_page
  end

  def new
    # @transaction_types = TransactionType.all
  end

  def create
    transaction_type = TransactionType.new transaction_type_params
    return redirect_to new_transaction_types_path if transaction_type.invalid?
    transaction_type.save!
    return redirect_to transaction_types_path
  end

  def edit
    return redirect_back_no_access_right unless params[:id].present?
    @transaction_type = TransactionType.find_by_id params[:id]
  end

  def update
    return redirect_back_no_access_right unless params[:id].present?
    transaction_type = Transaction.find_by_id params[:id]
    transaction_type.assign_attributes transaction_type_params
    transaction_type.save! if transaction_type.changed?
    return redirect_to transaction_types_path
  end

  private
    def transaction_type_params
      params.require(:transaction_type).permit(
        :name
      )
    end

    def param_page
      params[:page]
    end
end


