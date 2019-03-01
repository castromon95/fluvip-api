class ApplicationController < ActionController::API
  include FluvipError::ErrorHandler
  include Pundit

  def info_response(success, message, type)
    render json: { success: success,
                   info: {
                     message: message,
                     type: type
                   } }
  end
end
