class PetPolicy < ApplicationPolicy

  def index?
    user_admin?
  end

  def my_pets?
    user_not_admin?
  end

  def show?
    user_record?
  end

  def create?
    user_not_admin?
  end

  def update?
    user_record?
  end

  def amend?
    user_admin?
  end

  def permitted_attributes_for_create
    [:species, :breed, :name, :food, :diseases, :care]
  end

  def permitted_attributes_for_update
    [:species, :breed, :name, :food, :diseases, :care]
  end

  def permitted_attributes_for_amend
    [:species, :breed, :name, :food, :diseases, :care]
  end
end