class Api::V1::InvoicesController < ApplicationController
  def show
    invoice = Invoice.includes(:invoice_items, :payment).find(params[:id])
    render json: invoice.as_json(include: [:invoice_items, :payment])
  end
end
