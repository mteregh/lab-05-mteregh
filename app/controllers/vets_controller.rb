class VetsController < ApplicationController
  def index
    @vets = Vet.all
  end

  def show
  end
  
end