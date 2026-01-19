module Api
  module V1
    class BillingController < ApplicationController
      def run_cycle
        Billing::InvoiceGenerationJob.perform_async
        render json: { status: 'cycle triggered' }
      end
    end
  end
end
