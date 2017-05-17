class ProfilesController < ApplicationController
  before_action :require_code

  def index
    @others = Family.where week: current_family.week
    @bunkmates = Family.joins(:cabin).where("families.week=? and families.id != ?", current_family.week, current_family.id)
  end

  def campers
    people = People.where(family_id: current_family.id).order(:last,:first)
    @adults = people.select {|person| person.grade == 'Adult'}
    @kids = people.select {|person| person.grade != 'Adult'}
  end

  def toggle
    person = People.find params[:id]

    if params[:col] == 'no_dietary_issues'
      person.vegetarian = false
      person.vegan = false
      person.pescetarian = false
      person.gluten_free = false
      person.lactose_free = false
    end

    if ['vegetarian', 'vegan', 'pescetarian','gluten_free','lactose_free'].include? params[:col]
      person.no_dietary_issues = false
    end

    if params[:col] == 'no_allergies'
      person.allergies = ''
    end

    person.toggle params[:col]
    person.save
    redirect_to :profile_campers, notice: "Updated Preferences for #{person.first}"
  end

  def allergies
    person = People.find params[:id]
    person.no_allergies = false
    person.allergies = params[:allergies]
    person.save
    redirect_to :profile_campers, notice: "Updated Allergies for #{person.first}"
  end
end
