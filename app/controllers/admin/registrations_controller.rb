module Admin
  class RegistrationsController < ApplicationController
    before_action :require_admin
    before_action :set_registration, only: [:edit, :update, :destroy]

    def index
      @registrations = if params[:q].present?
                        Registration.joins(:event)
                                    .where("attendee_name ILIKE :q OR attendee_email ILIKE :q OR events.name ILIKE :q", q: "%#{params[:q]}%")
                      else
                        Registration.all
                      end
    end

    def bulk_delete
      Registration.where(id: params[:registration_ids]).destroy_all
      redirect_to admin_registrations_path, notice: "Selected registrations deleted."
    end

    def edit; end

    def update
      if @registration.update(registration_params)
        redirect_to admin_registrations_path, notice: "Registration updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @registration.destroy
      redirect_to admin_registrations_path, notice: "Registration deleted."
    end

    private

    def set_registration
      @registration = Registration.find(params[:id])
    end

    def registration_params
      params.require(:registration).permit(:attendee_name, :attendee_email, :event_id)
    end

    

    
  end
end
