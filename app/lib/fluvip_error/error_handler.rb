module FluvipError
  module ErrorHandler
    def self.included (clazz)
      clazz.class_eval do
        rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
        rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
      end
    end

    private

    def respond(message, status)
      render json: { success: false,
                     info: {
                         message: message,
                         type: 'Error'
                     } }, status: status
    end

    def record_not_found
      respond('No se encontro ningun registro con ese ifentificador!', 404)
    end

    def user_not_authorized
      respond('No estas autorizado para hacer esta accion!', 401)
    end
  end
end