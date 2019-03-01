class UserPolicy < ApplicationPolicy

  def retrieve_user?
    user_admin? && !@record.admin?
  end

end