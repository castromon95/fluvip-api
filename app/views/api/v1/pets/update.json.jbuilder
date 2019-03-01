if @success
  json.partial! 'api/v1/partials/info',
                success: @success,
                message: 'Mascota editada exitosamente!',
                type: 'success'
  json.pet @pet
else
  json.partial! 'api/v1/partials/info',
                success: @success,
                message: @pet.errors.full_messages.first,
                type: 'error'
end
json.success @success