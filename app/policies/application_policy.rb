class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def user_not_admin?
    !@user.admin?
  end

  def user_admin?
    @user.admin?
  end

  def user_record?
    @user.id == @record.user_id
  end
end