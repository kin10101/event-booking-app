class RegistrationsController < ApplicationController
  before_action :require_login
  before_action :set_event
  before_action :check_event_open, only: [:create, :edit, :update, :destroy]

  def create
    @registration = @event.registrations.build(registration_params)
    if @registration.save
      redirect_to event_path(@event), notice: "Registration successful."
    else
      redirect_to event_path(@event), alert: @registration.errors.full_messages.to_sentence
    end
  end

  def edit
    @registration = @event.registrations.find(params[:id])
  end

  def update
    @registration = @event.registrations.find(params[:id])
    if @registration.update(registration_params)
      redirect_to event_path(@event), notice: "Registration updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @registration = @event.registrations.find(params[:id])
    @registration.destroy
    redirect_to event_path(@event), notice: "Registration cancelled."
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def registration_params
    params.require(:registration).permit(:attendee_name, :attendee_email)
  end

  def check_event_open
    if @event.closed? && !current_user.admin?
      redirect_to event_path(@event), alert: "This event is closed. You cannot register or modify registrations."
    end
  end
end
