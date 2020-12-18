class Api::V1::ItemsController < ApplicationController
  def index
    items = Item.all.map do |item|
      {
        id: item.id.to_s,
        type: 'item',
        attributes: item.attributes
      }
    end

    structure = {
      data: items
    }

    render json: structure
  end

  def show
    item = Item.find(params[:id])

    render json: structure_single(item)
  rescue ActiveRecord::RecordNotFound
    render nothing: true, status: :no_content
  end

  def create
    item = Item.create!(permitted_params)

    render json: structure_single(item)
  end

  def update
    item = Item.find(params[:id])

    item.update(permitted_params)

    render json: structure_single(item)
  end

  def destroy
    item = Item.find(params[:id])

    item.destroy

    render nothing: true, status: :no_content
  end

  private

  def permitted_params
    params.permit(
      :name,
      :description,
      :unit_price,
      :merchant_id
    )
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
