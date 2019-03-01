Fabricator(:pet) do
  user
  species { Faker::Name.name }
  breed { Faker::Name.name }
  name { Faker::Name.name }
  food { Faker::Name.name }
  diseases ""
  care ""
end