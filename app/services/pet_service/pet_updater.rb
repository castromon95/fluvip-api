module PetService
  class PetUpdater < ApplicationService
    attr_reader :pet, :permitted_params
    def initialize(pet, permitted_params)
      @pet = pet
      @permitted_params = permitted_params
    end

    def execute
      @pet.update(@permitted_params)
    end
  end
end