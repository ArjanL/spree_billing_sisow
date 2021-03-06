module Spree
  class SisowStatusController < ApplicationController
    def update
      begin
        order = Order.find_by_number!(params[:order_id])
        sisow = BillingIntegration::SisowBilling.new(order)
        sisow.process_response(params)
        render :text => ""
      rescue ActiveRecord::RecordNotFound
        logger.error "ERROR: Sisow reply failed, order (#{params[:order_id]}) not found"
        render :text => "", :status => 500
      end
    end

  end
end
