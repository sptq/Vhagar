class LectureGroupsController < ApplicationController

  load_and_authorize_resource

  # GET /lecture_groups
  # GET /lecture_groups.json
  def index
  end

  # GET /lecture_groups/1
  # GET /lecture_groups/1.json
  def show
  end

  # GET /lecture_groups/new
  def new
  end

  # GET /lecture_groups/1/edit
  def edit
  end

  # POST /lecture_groups
  # POST /lecture_groups.json
  def create
    @lecture_group = LectureGroup.new(lecture_group_params)

    respond_to do |format|
      if @lecture_group.save
        format.html { redirect_to @lecture_group, notice: 'Lecture group was successfully created.' }
        format.json { render action: 'show', status: :created, location: @lecture_group }
      else
        format.html { render action: 'new' }
        format.json { render json: @lecture_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lecture_groups/1
  # PATCH/PUT /lecture_groups/1.json
  def update
    respond_to do |format|
      if @lecture_group.update(lecture_group_params)
        format.html { redirect_to @lecture_group, notice: 'Lecture group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @lecture_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lecture_groups/1
  # DELETE /lecture_groups/1.json
  def destroy
    @lecture_group.destroy
    respond_to do |format|
      format.html { redirect_to lecture_groups_url }
      format.json { head :no_content }
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def lecture_group_params
      params.require(:lecture_group).permit(:title, :description)
    end
end
