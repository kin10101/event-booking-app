module Admin
  class EventsController < ApplicationController
    before_action :require_admin
    before_action :set_event, only: [:show, :edit, :update, :destroy]

    def index
      @events = if params[:q].present?
                  Event.where("name ILIKE ? OR location ILIKE ?", "%#{params[:q]}%", "%#{params[:q]}%")
                else
                  Event.all
                end
    end

    def close
      event = Event.find(params[:id])
      event.update(closed: true)
      redirect_to admin_events_path, notice: "Event closed successfully."
    end
    
    def reopen
      event = Event.find(params[:id])
      event.update(closed: false)
      redirect_to admin_events_path, notice: "Event reopened successfully."
    end

    def bulk_delete
      if params[:event_ids].present?
        Event.where(id: params[:event_ids]).destroy_all
        redirect_to admin_events_path, notice: "Selected events deleted."
      else
        redirect_to admin_events_path, alert: "No events selected."
      end
    end

    def show; end
    def new; @event = Event.new; end
    def edit; end

    def create
      @event = Event.new(event_params)
      if @event.save
        redirect_to [:admin, @event], notice: "Event created."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @event.update(event_params)
        redirect_to [:admin, @event], notice: "Event updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @event.destroy
      redirect_to admin_events_path, notice: "Event deleted."
    end

    private

    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:name, :date, :location, :description, :user_id)
    end


    
  end
end
