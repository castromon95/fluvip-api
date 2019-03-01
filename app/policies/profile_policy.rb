class ProfilePolicy < ApplicationPolicy
  def show?
    user_not_admin?
  end

  def index?
    user_admin?
  end

  def update?
    user_not_admin?
  end

  def amend?
    user_admin?
  end

  def permitted_attributes_for_update
    [:name, :last_name, :phone]
  end

  def permitted_attributes_for_amend
    [:name, :last_name, :phone]
  end
end