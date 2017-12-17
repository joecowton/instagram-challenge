class CommentsController < ApplicationController
  before_action :load_picture, :load_user, only: [:show, :create, :edit, :update, :destroy]

  # GET /comments
  # GET /comments.json
  def index
    load_picture
    @comments = @picture.comments.all
  end

  def upvote
    @comment = Comment.find(params[:id])
    @comment.upvote_by current_user
    redirect_to user_pictures_path(current_user)
  end

  def downvote
    @comment = Comment.find(params[:id])
    @comment.downvote_by current_user
    redirect_to user_pictures_path(current_user)
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
    load_picture
    @comment = @picture.comments.find(params[:picture_id])
  end

  # GET /comments/new
  def new
    load_picture
    @comment = @picture.comments.new
  end

  # GET /comments/1/edit
  def edit
    load_picture
    @comment = @picture.comments.find(params[:picture_id])
  end

  # POST /comments
  # POST /comments.json
  def create
    load_picture
    @comment = @picture.comments.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to pictures_url  , notice: 'Comment was successfully created.' }
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
    load_picture
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
    load_picture
    @comment = @picture.comments.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to picture_comments_url, notice: 'Comment was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def load_picture
      @picture = Picture.find(params[:picture_id])
    end

    def load_user
      @user = User.find(current_user.id)
      p @user
    end

    def set_comment
      load_picture
      @comment = Comment.find(params[:picture_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      load_picture
      params.require(:comment).permit(:comment, :picture_id, :user_id)
    end
end
