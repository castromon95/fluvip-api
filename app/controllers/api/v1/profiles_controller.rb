class Api::V1::ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile, only: [:show, :update]
  before_action :retrieve_profile, only: [:amend]

  def show
    authorize @profile
  end

  def index
    authorize Profile
    @profiles = Profile.includes(:user).joins(:user).where('users.admin = ?', false)
  end

  def update
    authorize @profile
    @success = ProfileService::ProfileUpdater.execute(@profile, permitted_attributes(@profile))
  end

  def amend
    authorize @profile
    @success = ProfileService::ProfileUpdater.execute(@profile, permitted_attributes(@profile))
  end

  private

  def set_profile
    @profile = Profile.find_by_user_id(current_user)
  end

  def retrieve_profile
    @profile = Profile.find_by_user_id(params[:id])
  end
end
