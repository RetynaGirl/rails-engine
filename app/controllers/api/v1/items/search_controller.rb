class Api::V1::Items::SearchController < ApplicationController
  def show
    search_param = permit_params.to_h.first

    begin
      # item = Item.find_by!(search_param[0] => search_param[1])
      item = Item.where("#{search_param[0]} like ?", "%#{search_param[1]}%").limit(1).first

      item_data = {
        id: item.id,
        type: 'item',
        attributes: item.attributes
      }

      render json: item_data
    rescue ActiveRecord::RecordNotFound
      render nothing: true, status: :no_content
    end
  end

  private

  def permit_params
    params.except(:controller, :action).permit!
  end
end
