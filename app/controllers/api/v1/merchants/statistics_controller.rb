class Api::V1::Merchants::StatisticsController < ApplicationController
  def most_revenue
    quantity = params[:quantity] || 10

    # merchants = Merchant.find_by_sql('SELECT merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS sum_invoice_items_quantity_all_invoice_items_unit_price FROM "merchants" INNER JOIN "invoices" ON "invoices"."merchant_id" = "merchants"."id" INNER JOIN "invoice_items" ON "invoice_items"."invoice_id" = "invoices"."id" INNER JOIN "transactions" ON "transactions"."invoice_id" = "invoices"."id" WHERE (invoices.status = ' + "'shipped'" + ') AND (transactions.result = ' + "'success'" + ') GROUP BY merchants.id ORDER BY sum_invoice_items_quantity_all_invoice_items_unit_price DESC LIMIT ', + params[:quantity].to_s)

    # merchants = Merchant.select('merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS sum_invoice_items_quantity_all_invoice_items_unit_price')
    #                     .limit(params[:quantity])
    #                     .joins(:invoices)
    #                     .joins(:invoice_items, :transactions)
    #                     .where("invoices.status = 'shipped'")
    #                     .group('merchants.id')
    #                     .order('sum_invoice_items_quantity_all_invoice_items_unit_price DESC')
    #                     .where("transactions.result = 'success'")

    merchants_data = ActiveRecord::Base.connection.execute('SELECT merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS sum_invoice_items_quantity_all_invoice_items_unit_price
                                                       FROM "merchants"
                                                       INNER JOIN "invoices" ON "invoices"."merchant_id" = "merchants"."id"
                                                       INNER JOIN "invoice_items" ON "invoice_items"."invoice_id" = "invoices"."id"
                                                       INNER JOIN "transactions" ON "transactions"."invoice_id" = "invoices"."id"
                                                       WHERE (invoices.status = ' + "'shipped'" + ') AND (transactions.result = ' + "'success'" + ')
                                                       GROUP BY merchants.id
                                                       ORDER BY sum_invoice_items_quantity_all_invoice_items_unit_price DESC
                                                       ' + "LIMIT #{quantity}")
    begin

      merchants = merchants_data.map do |merchant_data|
        merchant = Merchant.new(merchant_data.except('sum_invoice_items_quantity_all_invoice_items_unit_price'))

        {
          id: merchant.id.to_s,
          type: 'merchant',
          attributes: merchant.attributes
        }
      end

      raise ActiveRecord::RecordNotFound, 'No search results' if merchants.length.zero?
      structure = {
        data: merchants
      }

      render json: structure
    rescue ActiveRecord::RecordNotFound
      render nothing: true, status: :no_content
    end
  end

  def most_items_sold
    quantity = params[:quantity] || 10
    # merchants = Merchant.select('merchants.*, SUM(invoice_items.quantity) AS sum_invoice_items_quantity')
    #                     .joins(:invoice_items, :transactions)
    #                     .where("invoices.status = 'shipped' AND (transactions.result = 'success')")
    #                     .group('merchants.id')
    #                     .order('sum_invoice_items_quantity DESC')
    #                     .limit(params[:quantity])

    merchants_data = ActiveRecord::Base.connection.execute('SELECT merchants.*, SUM(invoice_items.quantity) AS sum_invoice_items_quantity
                                                       FROM "merchants"
                                                       INNER JOIN "invoices" ON "invoices"."merchant_id" = "merchants"."id"
                                                       INNER JOIN "invoice_items" ON "invoice_items"."invoice_id" = "invoices"."id"
                                                       INNER JOIN "transactions" ON "transactions"."invoice_id" = "invoices"."id"
                                                       WHERE (invoices.status = ' + "'shipped'" + ') AND (transactions.result = ' + "'success'" + ')
                                                       GROUP BY merchants.id
                                                       ORDER BY sum_invoice_items_quantity DESC
                                                       ' + "LIMIT #{quantity}")

    # require 'pry'; binding.pry
    begin

      merchants = merchants_data.map do |merchant_data|
        merchant = Merchant.new(merchant_data.except('sum_invoice_items_quantity'))

        {
          id: merchant.id.to_s,
          type: 'merchant',
          attributes: merchant.attributes
        }
      end
      raise ActiveRecord::RecordNotFound, 'No search results' if merchants.length.zero?

      structure = {
        data: merchants
      }

      render json: structure
    rescue ActiveRecord::RecordNotFound
      render nothing: true, status: :no_content
    end
  end

  def revenue
    revenue = Merchant.find(params[:id])
                      .invoice_items
                      .where("invoices.status = 'shipped'")
                      .sum('invoice_items.quantity * invoice_items.unit_price')

    structure = {
      data: {
        id: nil,
        attributes: {
          revenue: revenue
        }
      }
    }

    render json: structure
  rescue ActiveRecord::RecordNotFound
    render nothing: true, status: :no_content
  end
end
