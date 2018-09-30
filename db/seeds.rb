# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Currency.delete_all
currency_1 = Currency.create(country_code: 'USD', denomination: '$')
currency_2 = Currency.create(country_code: 'GBP', denomination: '£')

ExchangeRate.delete_all
er1 = ExchangeRate.create(base_currency_id: 1, converted_currency_id: 2, rate: 1.2)
er2 = ExchangeRate.create(base_currency_id: 2, converted_currency_id: 1, rate: 0.8)
