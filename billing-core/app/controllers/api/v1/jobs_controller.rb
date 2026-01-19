module Api
  module V1
    class JobsController < ApplicationController

      # POST /api/v1/jobs/run_cycle
      #
      # Aciona o ciclo completo:
      # Subscription → Invoice → Payment → Gateway
      def run_cycle
        Billing::InvoiceGenerationJob.perform_async

        render json: {
          status: "ok",
          message: "Invoice generation triggered."
        }, status: :accepted
      end


      # POST /api/v1/jobs/process_pending_payments
      #
      # Opcional: reprocessar falhas
      def process_pending_payments
        Billing::PendingPaymentReprocessingJob.perform_async

        render json: {
          status: "ok",
          message: "Payment reprocessing triggered."
        }, status: :accepted
      end

    end
  end
end
