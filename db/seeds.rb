# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Currency.delete_all

# CREATE BASE CURRENCIES

currency_1 = Currency.create(country_code: 'USD', denomination: '$')
currency_2 = Currency.create(country_code: 'GBP', denomination: '£')
currency_3 = Currency.create(country_code: 'EUR', denomination: '€')
currency_4 = Currency.create(country_code: 'JPY', denomination: '¥')


# CREATE EXCHANGE RATES BETWEEN CURRENCIES

ExchangeRate.delete_all

# USD > EXCHANGE RATES
us_e1 = ExchangeRate.create(base_currency_id: currency_1.id, converted_currency_id: currency_2.id, rate: 0.77)
us_e2 = ExchangeRate.create(base_currency_id: currency_1.id, converted_currency_id: currency_3.id, rate: 0.86)
us_e3 = ExchangeRate.create(base_currency_id: currency_1.id, converted_currency_id: currency_4.id, rate: 113)

# GBP > EXCHANGE RATES
gb_e1 = ExchangeRate.create(base_currency_id: currency_2.id, converted_currency_id: currency_1.id, rate: 1.2)
gb_e2 = ExchangeRate.create(base_currency_id: currency_2.id, converted_currency_id: currency_3.id, rate: 1.1)
gb_e3 = ExchangeRate.create(base_currency_id: currency_2.id, converted_currency_id: currency_4.id, rate: 148)


# CREATE QUOTATIONS BASED ON EXCHANGE RATES AND REQUETSED AMOUNT

Quotation.delete_all
#
q1 = Quotation.create(based_requested_amount: 100, exchange_rate_id: us_e1.id)
q2 = Quotation.create(based_requested_amount: 200, exchange_rate_id: gb_e1.id)
q3 = Quotation.create(based_requested_amount: 100, exchange_rate_id: us_e2.id)
q4 = Quotation.create(based_requested_amount: 100, exchange_rate_id: gb_e2.id)
q5 = Quotation.create(based_requested_amount: 100, exchange_rate_id: gb_e3.id)

User.delete_all
user = User.create(name: 'Test')


# CREATE ORDERS FROM THE QUOTATIONS

Order.delete_all
o1 = Order.create(quotation_id: q1.id, user_id: user.id )
o2 = Order.create(quotation_id: q2.id, user_id: user.id )
o3 = Order.create(quotation_id: q3.id, user_id: user.id )
o4 = Order.create(quotation_id: q4.id, user_id: user.id )
o5 = Order.create(quotation_id: q5.id, user_id: user.id )
