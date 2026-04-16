class AppointmentsController < ApplicationController
  def index
    @appointments = Appointment.includes(:pet, :vet)
  end

  def show
  end
  
end