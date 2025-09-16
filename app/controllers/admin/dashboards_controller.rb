module Admin
  class DashboardsController < ApplicationController
    before_action :require_admin

    def index
      @total_events = Event.count
      @total_registrations = Registration.count
    end
  end
end
