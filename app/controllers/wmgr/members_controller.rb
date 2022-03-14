class Wmgr::MembersController < ApplicationController
  before_action :authenticate_user!
  before_action do
    redirect_to :denied unless current_user.admin?
  end

  def new
    @person = People.new
    @person.family_id = params[:id]
  end

  def edit
    @person = People.find(params[:id])
  end

  def create
    @person = People.new person_params(params)
    @person.family_id = params[:family_id]

    if @person.save
      redirect_to wmgr_family_path(@person.family_id), notice: 'Person created.'
    else
      render :action => "new"
    end
  end

  def update
    @person = People.find(params[:id])

    if @person.update_attributes(person_params(params))
      redirect_to wmgr_family_path(@person.family_id), notice: "#{@person.first} #{@person.last} was successfully updated."
    else
      render :action => "edit"
    end
  end

  def delete
    person = People.find params[:id]

    if person.delete
      redirect_to wmgr_family_path(person.family_id), notice: "#{person.first} #{person.last} has been deleted."
    else
      redirect_to wmgr_family_path(person.family_id), alert: "#{person.first} #{person.last} could not be deleted."
    end
  end

  def person_params params
    params.require(:people).permit(:first, :last, :grade)
  end

end