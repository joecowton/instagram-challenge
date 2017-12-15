class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :edit, :update, :destroy]

  # GET /pictures
  # GET /pictures.json
  def index
    @pictures = current_user.pictures.all
    p current_user.pictures.all
  end

  # GET /pictures/1
  # GET /pictures/1.json
  def show
    @picture = current_user.pictures.find(params[:id])
  end

  # GET /pictures/new
  def new
    @picture = current_user.pictures.new
  end

  # GET /pictures/1/edit
  def edit
    @picture = current_user.pictures.find(params[:id])
  end

  # POST /pictures
  # POST /pictures.json
  def create
    @picture = current_user.pictures.new(picture_params)

    respond_to do |format|
      if @picture.save
        format.html { redirect_to [current_user, @picture], notice: 'Picture was successfully created.' }
        format.json { render :show, status: :created, location: @picture }
      else
        format.html { render :new }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pictures/1
  # PATCH/PUT /pictures/1.json
  def update
     @picture = current_user.pictures.find(params[:id])

    respond_to do |format|
      if @picture.update(picture_params)
        format.html { redirect_to [current_user,@picture], notice: 'Picture was successfully updated.' }
        format.json { render :show, status: :ok, location: @picture }
      else
        format.html { render :edit }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pictures/1
  # DELETE /pictures/1.json
  def destroy
    @picture = current_user.pictures.find(params[:id])

    @picture.destroy
    respond_to do |format|
      format.html { redirect_to user_pictures_path(current_user), notice: 'Picture was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private



    # Use callbacks to share common setup or constraints between actions.
    def set_picture
      @picture = Picture.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def picture_params
      params.require(:picture).permit(:image, :user_id)
    end
end
