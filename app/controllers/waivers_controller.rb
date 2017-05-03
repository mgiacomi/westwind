class WaiversController < ApplicationController
  before_action :require_code

  def index
    people = People.where(family_id: current_family.id).order(:last,:first)
    @adults = people.select {|person| person.grade == 'Adult'}
    @kids = people.select {|person| person.grade != 'Adult'}
  end

  def form
    @person = People.find params[:id]
    @waiver = Waiver.new
  end

  def submit
    @person = People.find params[:id]
    @waiver = Waiver.new(waiver_params(params))
    @waiver.person_id = @person.id

    if @waiver.save
      redirect_to :waivers_index, notice: "Waiver for #{@person.first} has been signed."
    else
      render :form
    end
  end

  private

  def waiver_params params
    params.require(:waiver).permit(:understand, :first, :last, :email, :phone, :relationship, :signature)
  end
end
