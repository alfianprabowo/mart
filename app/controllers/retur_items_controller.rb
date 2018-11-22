class ReturItemsController < ApplicationController
  before_action :require_login
  def index
    return redirect_back_no_access_right unless params[:id].present?
    @retur_items = ReturItem.page param_page
    @retur_items = @retur_items.where(retur_id: params[:id])
  end

  def feedback
    return redirect_back_no_access_right unless params[:id].present?
    @retur = Retur.find params[:id]
    return redirect_to returs_path unless @retur.present?
    @retur_items = ReturItem.where(retur_id: @retur.id)
  end

  def confirmation_feedback

  end

  private
    def param_page
      params[:page]
    end
end
