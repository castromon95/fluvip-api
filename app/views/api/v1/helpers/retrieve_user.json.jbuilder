json.success true
json.user do
  json.email @user.email
  json.profile @user.profile
  json.petList do
    json.entries @user.pets
    json.totalCount @user.pets.size
  end
end