class StoriesController < ApplicationController
  before_action :set_story, only: [:show, :edit, :update, :destroy]

  # GET /users/:user_id/stories
  def index
    @user = User.find(params[:user_id])
    @stories = Story.where(user_id: params[:user_id]).order(created_at: :asc)
    render 'users/show.html', locals: { content: 'user_stories' }
  end

  # GET /users/:user_id/stories/:id
  def show
    render :show
  end

  # GET /users/:user_id/stories/new
  def new
    @story = Story.new
    render :new
  end

  # GET /users/:user_id/stories/:id/edit
  def edit
    render :edit unless !has_privilege?
  end

  # POST /users/:user_id/stories
  def create
    @story = Story.new(story_params)
    @story.user = current_user

    logger.debug "SAVING NEW STORY: #{@story.attributes.inspect}"
    if @story.save
      redirect_to user_stories_path(current_user.id), notice: 'Story was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /users/:user_id/stories/:id
  def update
    has_privilege?
    if @story.update(story_params)
      redirect_to user_story_path(current_user, @story), notice: 'Story was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /users/:user_id/stories/:id
  def destroy
    has_privilege?
    @story.destroy
    redirect_to user_stories_path(current_user), notice: 'Story was successfully destroyed.'
  end

  private

    # check user editing privileges
    def has_privilege?
      if (!logged_in?)
        redirect_to '/login' and return
      elsif (params[:user_id].to_i != current_user.id)
        redirect_to user_stories_path(current_user) and return
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_story
      @story = Story.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def story_params
      params.require(:story).permit(:headline, :body, :image)
    end

end
