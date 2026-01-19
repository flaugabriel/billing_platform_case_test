class Api::V1::InvoicesController < ApplicationController

  def index
    invoices = Invoice.all
    render json: invoices.as_json(only: [:id, :client_id, :status])
  end

  def show
    invoice = Invoice.includes(:invoice_items, :payment).find(params[:id])
    render json: invoice.as_json(include: [:invoice_items, :payment])
  end
end
