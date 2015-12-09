class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /users/:user_id/events
  def index
    @user = User.find(params[:user_id])
    @events = Event.where(user_id: params[:user_id]).order(start_datetime: :asc)
    render 'users/show.html', locals: { content: 'user_events' }
  end

  # GET /users/:user_id/events/:id
  def show
    render :show
  end

  # GET /users/:user_id/events/new
  def new
    @event = Event.new
    render :new
  end

  # GET /users/:user_id/events/:id/edit
  def edit
    render :edit unless !has_privilege?
  end

  # POST /users/:user_id/events
  def create
    @event = Event.new(event_params)
    @event.user = current_user

    logger.debug "SAVING NEW EVENT: #{@event.attributes.inspect}"
    if @event.save
      redirect_to user_events_path(current_user.id), notice: 'Event was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /users/:user_id/events/:id
  def update
    has_privilege?
    if @event.update(event_params)
      redirect_to user_event_path(current_user, @event), notice: 'Event was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /users/:user_id/events/:id
  def destroy
    has_privilege?
    @event.destroy
    redirect_to user_events_path(current_user), notice: 'Event was successfully destroyed.'
  end

  private

    # check user editing privileges
    def has_privilege?
      if (!logged_in?)
        redirect_to '/login' and return
      elsif (params[:user_id].to_i != current_user.id)
        redirect_to user_events_path(current_user) and return
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:name, :description, :location, :start_datetime, :end_datetime, :image)
    end

end
