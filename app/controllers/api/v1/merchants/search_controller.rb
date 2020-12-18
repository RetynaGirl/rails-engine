class Api::V1::Merchants::SearchController < ApplicationController
  def show
    search_param = permit_params.to_h.first

    begin

      merchant = Merchant.where("#{search_param[0]} ilike ?", "%#{search_param[1]}%").limit(1).first


      render json: structure_single(merchant)
    rescue ActiveRecord::RecordNotFound, NoMethodError
      render nothing: true, status: :no_content
    end
  end

  def index
    search_param = permit_params.to_h.first
    begin
      merchants = Merchant.where("#{search_param[0]} ilike ?", "%#{search_param[1]}%")

      raise ActiveRecord::RecordNotFound.new('No search results') if merchants.length.zero?

      merchants_data = merchants.map do |merchant|
        {
          id: merchant.id,
          type: 'merchant',
          attributes: merchant.attributes
        }
      end

      structure = {
        data: merchants_data
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

  def structure_single(merchant)
    merchant_data = {
      id: merchant.id.to_s,
      type: 'merchant',
      attributes: merchant.attributes
    }

    {
      data: merchant_data
    }
  end
end
