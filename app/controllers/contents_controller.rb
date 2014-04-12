class ContentsController < ApplicationController

  load_and_authorize_resource

  # GET /contents
  # GET /contents.json
  def index
  end

  # GET /contents/1
  # GET /contents/1.json
  def show
  end

  # GET /contents/new
  def new
  end

  # GET /contents/1/edit
  def edit
  end

  # POST /contents
  # POST /contents.json
  def create
    respond_to do |format|
      if @content.save
        format.html { redirect_to @content, notice: 'Content was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # PATCH/PUT /contents/1
  # PATCH/PUT /contents/1.json
  def update
  	if @content.update(content_params)
  		redirect_to @content, notice: 'Content was successfully updated.'
  	else
      redirect_to @content
  	end
  end

  # DELETE /contents/1
  # DELETE /contents/1.json
  def destroy
  	redirect_to contents_url, alert: "Akcja niedozwolona"
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def content_params
      params.require(:content).permit(:title, :body, :image_url, :place)
    end
end
