class VaccinesController < ApplicationController
  before_action :require_code

  def index
    @vaccine = current_family.vaccine
    @vaccine = @vaccine ||= Vaccine.new
  end

  def submit
    @vaccine = Vaccine.find_or_create_by(family_id: current_family.id)
    @vaccine.attributes = vaccine_params

    if @vaccine.save
      redirect_to :profile_index, notice: "Vaccine Attestation signed."
    else
      render :index
    end
  end

  private

  def vaccine_params
    params.require(:vaccine).permit(:understand, :first, :last, :email, :phone, :party, :signature)
  end
end
