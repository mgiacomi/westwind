class ProfilesController < ApplicationController
  before_action :require_code

  def index
    @others = Family.where week: current_family.week
  end

  def campers
    people = People.where(family_id: current_family.id).order(:last,:first)
    @adults = people.select {|person| person.grade == 'Adult'}
    @kids = people.select {|person| person.grade != 'Adult'}
  end

  def toggle
    person = People.find params[:id]
    person.toggle params[:col]
    person.save
    redirect_to :profile_campers, notice: "Updated Preferences for #{person.first}"
  end

  def allergies
    person = People.find params[:id]
    person.allergies = params[:allergies]
    person.save
    redirect_to :profile_campers, notice: "Updated Allergies for #{person.first}"
  end
end
