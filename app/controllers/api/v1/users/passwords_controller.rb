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
      info_response(true, find_message('send_instructions'), 'success')
    elsif resource.errors.any?
      info_response(false, resource.errors.full_messages.first, 'error')
    else
      info_response(true, find_message('updated'), 'success')
    end
  end

end
