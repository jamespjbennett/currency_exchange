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
er1 = ExchangeRate.create(base_currency_id: 1, converted_currency_id: 2, rate: 0.8)
er2 = ExchangeRate.create(base_currency_id: 2, converted_currency_id: 1, rate: 1.2)

Quotation.delete_all
q1 = Quotation.create(based_requested_amount: 100, exchange_rate_id: er1.id)
q2 = Quotation.create(based_requested_amount: 200, exchange_rate_id: er2.id)

User.delete_all
user = User.create(name: 'Test')

Order.delete_all
o1 = Order.create(quotation_id: q1.id, user_id: user.id )
o1 = Order.create(quotation_id: q2.id, user_id: user.id )
