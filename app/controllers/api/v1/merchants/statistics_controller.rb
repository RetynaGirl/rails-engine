class Api::V1::Merchants::StatisticsController < ApplicationController
  def most_revenue
    merchants = Merchant.select('merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS sum_invoice_items_quantity_all_invoice_items_unit_price')
                        .joins(:invoice_items)
                        .where("invoices.status = 'shipped'")
                        .group('merchants.id')
                        .order('sum_invoice_items_quantity_all_invoice_items_unit_price DESC')
                        .limit(params[:quantity])

    begin
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

  def most_items_sold
    merchants = Merchant.select('merchants.*, SUM(invoice_items.quantity) AS sum_invoice_items_quantity')
                        .joins(:invoice_items)
                        .where("invoices.status = 'shipped'")
                        .group('merchants.id')
                        .order('sum_invoice_items_quantity DESC')
                        .limit(params[:quantity])

    begin
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
end
