class LecturesController < ApplicationController

  load_and_authorize_resource

  before_filter :authenticate_user!

  # GET /admin/lectures
  # GET /admin/lectures.json
  def index
  end

  # GET /admin/lectures/1
  # GET /admin/lectures/1.json
  def show
  end

  # GET /admin/lectures/new
  def new
  end

  # GET /admin/lectures/1/edit
  def edit
  end

  # POST /admin/lectures
  # POST /admin/lectures.json
  def create

    respond_to do |format|
      if @lecture.save
        format.html { redirect_to lectures_path, notice: 'Lecture was successfully created.' }
        format.json { render action: 'show', status: :created, location: @lecture }
      else
        format.html { render action: 'new' }
        format.json { render json: @lecture.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/lectures/1
  # PATCH/PUT /admin/lectures/1.json
  def update
    respond_to do |format|
      if @lecture.update(lecture_params)
        format.html { redirect_to lectures_path, notice: 'Lecture was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @lecture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/lectures/1
  # DELETE /admin/lectures/1.json
  def destroy
    @lecture.destroy
    respond_to do |format|
      format.html { redirect_to lectures_url }
      format.json { head :no_content }
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def lecture_params
      params.require(:lecture).permit(:title, :description, :start_date)
    end
end
