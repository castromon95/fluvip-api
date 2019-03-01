module PetService
  class PetCreator < ApplicationService
    attr_reader :user, :pet, :permitted_params
    def initialize(user, pet, permitted_params)
      @user = user
      @pet = pet
      @permitted_params = permitted_params
    end

    def execute
      @pet.assign_attributes(@permitted_params)
      @pet.user = @user
      @pet.save
    end
  end
end