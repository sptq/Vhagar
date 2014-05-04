class LecturesController < ApplicationController

  load_and_authorize_resource

  include ApplicationHelper

  # GET /lectures
  # GET /lectures.json
  def index
    @lectures = Lecture.all.order(:start_date)
  end

  # GET /lectures/1
  # GET /lectures/1.json
  def show
  end

  # GET /lectures/new
  def new
  end

  # GET /lectures/1/edit
  def edit
  end

  # POST /lectures
  # POST /lectures.json
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

  # PATCH/PUT /lectures/1
  # PATCH/PUT /lectures/1.json
  def update
    room = Room.where(id: params[:lecture][:room_id]).first
    if room.capacity < @lecture.participants.count
      redirect_to @lecture, alert: "Room with capacity #{room.capacity} wont fit #{@lecture.participants.count} participants"
    else
      respond_to do |format|
        if @lecture.update(lecture_params)
          format.html { redirect_to lectures_path, notice: 'Lecture was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: :edit }
          format.json { render json: @lecture.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /lectures/1
  # DELETE /lectures/1.json
  def destroy
    if @lecture.participants.count > 0 then
      redirect_to @lecture, alert: "Lecture has #{@lecture.participants.count} participants"
    else
      @lecture.room.lectures.delete @lecture
      @lecture.destroy
      respond_to do |format|
        format.html { redirect_to lectures_url }
        format.json { head :no_content }
      end
    end
  end

  def confirm
    barcode = params[:barcode]

    if user = @lecture.participants.select { |u| u.barcode == barcode }.first
      participation = extract_participation(@lecture, user)
      if participation.confirmed_at
        redirect_to @lecture, notice: "Użytkownik z kodem #{barcode} już uczestniczy w wydarzeniu"
      else
        participation.confirmed_at = Time.now
        participation.save
        redirect_to @lecture, notice: "Użytkownik z kodem #{barcode} został dołączony do wydarzenia"
      end
    else
      # jeżeli wykład jest otwarty
      if user = User.where(barcode: barcode).first
        @lecture.participants.push user
        participation = extract_participation(@lecture, user)
        participation.confirmed_at = Time.now
        participation.save
        redirect_to @lecture, notice: "Użytkownik z kodem #{barcode} został dołączony do wydarzenia"
      else
        redirect_to @lecture, alert: "Użytkownik z kodem #{barcode} nie został znaleziony"
      end
    end
  end

  def attend
    @lecture.participants << current_user
    redirect_to lectures_path, notice: "Dołączono do #{@lecture.title}"
  end

  def resign
    @lecture.participants.delete current_user
    redirect_to lectures_path, notice: "Opuszczono #{@lecture.title}"
  end

  def add
    user = User.where(id: params[:user_id]).last
    if user
      @lecture.participants.push user
      redirect_to :back, notice: "Dodałeś użytkownika #{user.email} do wydarzenia #{@lecture.title}"
    else
      redirect_to :back, alert: 'Nie znalazłem użytkownika :('
    end
  end

  def modify_users
    if current_user.role? :admin
      @users = User.all.to_a - @lecture.participants.to_a
    else
      @users = User.where(user_role: :user).to_a - @lecture.participants.to_a
    end
  end

  def remove
    user = User.where(id: params[:user_id]).last
    if user
      @lecture.participants.delete user
      redirect_to :back, notice: "Usunąłeś użytkownika #{user.email} z wydarzenia #{@lecture.title}"
    else
      redirect_to :back, alert: 'Nie znalazłem użytkownika :('
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def lecture_params
      params.require(:lecture).permit(:title, :description, :start_date, :room_id, :duration, :reserved, :barcode)
    end
end
