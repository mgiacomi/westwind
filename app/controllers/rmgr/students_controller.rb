class Rmgr::StudentsController < ApplicationController
  before_filter :authenticate_user!
  before_filter do
    redirect_to :denied unless current_user.admin?
  end

  def index
    @teacher_id = params[:teacher_id]
    @teachers = People.order(:grade).all.map { |t| ["#{t.first} #{t.last}", t.id] }

    if @teacher_id == nil
      @teacher_id = @teachers[0][1]
    end

    @students = Family.joins(:teacher).where("teachers.id=?", @teacher_id).order("last")
  end

  def new
    @student = Family.new
    @student.build_teacher
    @teachers = People.order(:grade).all.map { |t| ["#{t.first} #{t.last}", t.id] }
  end

  def show
    @student = Family.find(params[:id])
  end

  def edit
    @student = Family.find(params[:id])
    @teachers = People.order(:grade).all.map { |t| ["#{t.first} #{t.last}", t.id] }
  end

  def create
    @student = Family.new(student_params(params))

    if @student.save
      teacher = People.find(@student.teacher_id)
      redirect_to rmgr_students_path(teacher_id: teacher.id), notice: {title: 'Success', msg: 'Added student successfully.'}
    else
      render :new
    end
  end

  def update
    @student = Family.find(params[:id])

    if @student.update_attributes(student_params(params))
      teacher = People.find(@student.teacher_id)
      redirect_to rmgr_students_path(teacher_id: teacher.id), notice: {title: 'Success', msg: 'Family was successfully updated.'}
    else
      render :edit
    end
  end

  def send_flyer
    @student = Family.find(params[:id])
    teacher = People.find(@student.teacher_id)
    GeneralMailer.welcome_flyer(@student).deliver
    @student.update_attribute :flyer_sent_date, Time.zone.today
    redirect_to rmgr_students_path(teacher_id: teacher.id), notice: {title: 'Success', msg: 'Welcome flyer was sent.'}
  end

#  def destroy
#    student = Family.find(params[:id])
#    student.destroy
#    redirect_to rmgr_students_path
#  end

  private

  def student_params params
    params.require(:student).permit(:first, :last, :email, :email2, :teacher_id)
  end

end