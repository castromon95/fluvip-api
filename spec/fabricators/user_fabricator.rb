Fabricator(:user) do
  email { Faker::Internet.email }
  password '123456'
  password_confirmation '123456'
  confirmed_at {Faker::Date.backward(14)}
  admin false
end