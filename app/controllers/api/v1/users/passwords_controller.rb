# frozen_string_literal: true

class Api::V1::Users::PasswordsController < Devise::PasswordsController
  # GET /resource/password/new
  # def new
  #   super
  # end

  # POST /resource/password
  # def create
  #   super
  # end

  # GET /resource/password/edit?reset_password_token=abcdef
  # def edit
  #   super
  # end

  # PUT /resource/password
  # def update
  #   super
  # end

  # protected

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end

  private

  def respond_with(resource, _opts = {})
    if resource.blank?
      render json: { success: true, data: { message: find_message('send_instructions') } }
    elsif resource.errors.any?
      render json: { success: false, data: { message: resource.errors.full_messages.first } }
    else
      render json: { success: true, data: { message: find_message('updated') } }
    end
  end

end
