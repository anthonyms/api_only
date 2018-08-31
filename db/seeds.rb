# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
User.where(phone: '+254000000000').first_or_create!(email: 'system@system.com', password: '5y5t3m')
Account.where(user: User.find_by(phone: '+254000000000')).first_or_create!