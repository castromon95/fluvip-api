# frozen_string_literal: true

class Api::V1::Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    super
    ProfileService::ProfileCreator.execute(@user) if @user.persisted?
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  private

  def respond_with(resource, _opts = {})
    if resource.errors.any?
      render json: { success: false,
                     info: {
                       message: resource.errors.full_messages.first,
                       type: 'error'
                     } }
    elsif resource.active_for_authentication?
      render json: { success: true,
                     auth: {
                       logged: true,
                       jwt_token: request.env['warden-jwt_auth.token']
                     } }
    else
      render json: { success: true,
                     info: {
                       message: find_message("signed_up_but_#{resource.inactive_message}"),
                       type: 'success'
                     } }
    end
  end
end
