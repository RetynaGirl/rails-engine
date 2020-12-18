class Api::V1::StatisticsController < ApplicationController
  def revenue_date_range
    start_date = Date.new(*params[:start].split(/[^0-9]/).map(&:to_i))
    end_date = Date.new(*params[:end].split(/[^0-9]/).map(&:to_i))

    data = InvoiceItem.where(created_at: start_date..end_date).sum("quantity * unit_price").to_f

    structure = {
      data: {
        id: nil,
        attributes: {
          revenue: data
        }
      }
    }

    render json: structure
  end
end
