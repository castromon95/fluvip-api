class User < ApplicationRecord
  has_one :profile
  has_many :pets
  accepts_nested_attributes_for :profile

  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: Devise::JWT::RevocationStrategies::Null

  # Active Record Callbacks
  before_create do
    self.admin ||= false
  end

  def jwt_payload
    { iss: 'FLUVIP' }
  end

end
