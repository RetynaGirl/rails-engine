class Api::V1::Items::SearchController < ApplicationController
  def show
    search_param = permit_params.to_h.first

    begin
      item = Item.where("#{search_param[0]} ilike ?", "%#{search_param[1]}%").limit(1).first



      render json: structure_single(item)
    rescue ActiveRecord::RecordNotFound, NoMethodError
      render nothing: true, status: :no_content
    end
  end

  def index
    search_param = permit_params.to_h.first
    begin
      items = Item.where("#{search_param[0]} ilike ?", "%#{search_param[1]}%")

      raise ActiveRecord::RecordNotFound.new('No search results') if items.length.zero?

      items_data = items.map do |item|
        {
          id: item.id,
          type: 'item',
          attributes: item.attributes
        }
      end

      structure = {
        data: items_data
      }

      render json: structure
    rescue ActiveRecord::RecordNotFound
      render nothing: true, status: :no_content
    end
  end

  private

  def permit_params
    params.except(:controller, :action).permit!
  end

  def structure_single(item)
    item_data = {
      id: item.id.to_s,
      type: 'item',
      attributes: item.attributes
    }

    {
      data: item_data
    }
  end
end
