json.success true
json.profileList do
  json.entries @profiles
  json.totalCount @profiles.size
end