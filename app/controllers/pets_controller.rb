class PetsController < ApplicationController
  def index
    @pets = Pet.includes(:owner)
  end

  def show
    
  end

end