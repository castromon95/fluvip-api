Fabricator(:profile) do
  user
  name { Faker::Name.name }
  last_name { Faker::Name.name }
  phone { Faker::PhoneNumber.cell_phone }
end