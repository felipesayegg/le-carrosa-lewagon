# db/seeds.rb

require 'faker'

# Criando alguns usuários
User.create(email: 'felipesayeg2018@gmail.com', password: '123123')
User.create(email: 'marcosoftn1@gmail.com', password: '123123')

# Povoando a tabela de cars com Faker
10.times do
  Car.create(
    year: Faker::Number.between(from: 2000, to: 2022),
    brand: Faker::Vehicle.make,
    mod: Faker::Vehicle.model,
    description: Faker::Vehicle.standard_specs,
    price: Faker::Commerce.price(range: 10000.0..80000.0),
    km: "#{Faker::Number.between(from: 1000, to: 100000)} km",
    user_id: Faker::Number.between(from: 1, to: 2) # associando aleatoriamente com um dos usuários criados acima
  )
end
