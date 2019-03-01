if @success
  json.partial! 'api/v1/partials/info',
                success: @success,
                message: 'Perfil editado exitosamente!',
                type: 'success'
  json.profile @profile
else
  json.partial! 'api/v1/partials/info',
                success: @success,
                message: @profile.errors.full_messages.first,
                type: 'error'
end
json.success @success
