class CommentsController < ApplicationController
  before_action :load_picture, :set_comment, only: [:show, :create, :edit, :update, :destroy]

  # GET /comments
  # GET /comments.json
  def index
    @comments = @picture.comments.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show

    @comment = @picture.comments.find(params[:id])
    p @comment
  end

  # GET /comments/new
  def new
    load_picture
    @comment = @picture.comments.new
  end

  # GET /comments/1/edit
  def edit
    @comment = @picture.comments.find(params[:id])
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = @picture.comments.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment, notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update

    @comment = @picture.comments.find(params[:id])

    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment = @picture.comments.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to picture_comments_url, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def load_picture
      @picture = Picture.find(params[:picture_id])
    end

    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:comment)
    end
end
