# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


User.create!(
  first_name: 'Emily',
  last_name: 'P',
  email: 'emily@example.com',
  password: 'password',
  password_confirmation: 'password',
  confirmation: true
)

User.create!(
  first_name: 'Bebe',
  last_name: 'P',
  email: 'bebe@example.com',
  password: 'password',
  password_confirmation: 'password',
  confirmation: true
)

User.create!(
  first_name: 'Stranger',
  last_name: 'D',
  email: 'stranger@example.com',
  password: 'password',
  password_confirmation: 'password',
  confirmation: true
)

User.create!(
  first_name: 'Thom',
  last_name: 'F',
  email: 'thom@example.com',
  password: 'password',
  password_confirmation: 'password',
  confirmation: true
)
