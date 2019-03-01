class Api::V1::HelpersController < ApplicationController

  before_action :authenticate_user!
  before_action :set_user, only: [:retrieve_user]

  def verify_token
    @token = request.headers['Authorization'].split(' ')[1]
  end

  def retrieve_user
    authorize @user
  end

  private

  def set_user
    @user = User.includes([:profile, :pets]).find(params[:id])
  end
end
