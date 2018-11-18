class ReturnItemsController < ApplicationController
  before_action :require_login
  def index
    return redirect_back_no_access_right unless params[:id].present?
    @return_items = ReturnItem.page param_page
    @return_items = @return_items.where(return_id: params[:id])
  end

  private
    def param_page
      params[:page]
    end
end
