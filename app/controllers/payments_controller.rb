class PaymentsController < ApplicationController
  before_action :require_code, :only => :index
  skip_before_action :verify_authenticity_token, :only => [:receipt, :onk_receipt]

  def index
  end

  def receipt
    if params[:payment_status] == "Completed"
      family_id = params[:invoice].split('-')[0]

      payment = Payment.new
      payment.amount = params[:payment_gross]
      payment.fee = params[:payment_fee]
      payment.pmtdate = params[:payment_date]
      payment.pmttype = "Paypal"
      payment.family_id = family_id

      if payment.save
        logger.info "Saved Payment: #{params[:invoice]} #{params[:payment_gross]} #{params[:payment_status]} #{params[:payment_date]}"
      else
        logger.info "Failed to save payment: #{params[:invoice]} #{params[:payment_gross]} #{params[:payment_status]} #{params[:payment_date]}"
      end
    end
  end

  def onk_receipt
    if params[:payment_status] == "Completed"
      id = params[:invoice].split('-')[0]
      family = Family.find id
      family.onk_member = true

      if family.save
        logger.info "ONK Membership added for registration id: #{registration.id}"
      else
        logger.info "Failed to add ONK Membership for registration id: #{registration.id}"
      end
    end
  end
end
