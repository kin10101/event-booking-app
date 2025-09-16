class EventsController < ApplicationController
  before_action :require_login
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :check_event_open, only: [:edit, :update, :destroy]

  def index
    if current_user.admin?
      @events = Event.all
    else
      @events = current_user.events
    end
  end

  def show
    @registrations = @event.registrations
    @registration = Registration.new
  end

  def new
    @event = current_user.events.build
  end

  def create
    @event = current_user.events.build(event_params)
    if @event.save
      redirect_to events_path, notice: "Event created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @event.update(event_params)
      redirect_to events_path, notice: "Event updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event.destroy
    redirect_to events_path, notice: "Event deleted successfully."
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:name, :date, :location, :description)
  end

  def check_event_open
    if @event.closed? && !current_user.admin?
      redirect_to events_path, alert: "This event is closed and cannot be modified."
    end
  end
end
