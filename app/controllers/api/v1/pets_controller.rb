class Api::V1::PetsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_pet, only: [:show, :update, :amend]
  before_action :initialize_pet, only: [:create]

  def index
    authorize Pet
    @pets = Pet.all
  end

  def my_pets
    authorize Pet
    @pets = Pet.where(user: current_user)
  end

  def show
    authorize @pet
  end

  def create
    authorize @pet
    @success = PetService::PetCreator.execute(current_user, @pet, permitted_attributes(Pet))
  end

  def update
    authorize @pet
    @success = PetService::PetUpdater.execute(@pet, permitted_attributes(@pet))
  end

  def amend
    authorize @pet
    @success = PetService::PetUpdater.execute(@pet, permitted_attributes(@pet))
  end

  private

  def set_pet
    @pet = Pet.find(params[:id])
  end

  def initialize_pet
    @pet = Pet.new
  end
end
