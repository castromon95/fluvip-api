json.success true
json.auth do
  json.logged true
  json.jwt_token @token
  json.admin current_user.admin
end