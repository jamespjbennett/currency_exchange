# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Currency.delete_all

# CREATE BASE CURRENCIES

usd = Currency.create(country_code: 'USD', denomination: '$')
gbp = Currency.create(country_code: 'GBP', denomination: '£')
eur = Currency.create(country_code: 'EUR', denomination: '€')
jpy = Currency.create(country_code: 'JPY', denomination: '¥')
chi = Currency.create(country_code: 'CHI', denomination: '¥')


# CREATE EXCHANGE RATES BETWEEN CURRENCIES

ExchangeRate.delete_all

# USD > EXCHANGE RATES
us_e1 = ExchangeRate.create(base_currency_id: usd.id, converted_currency_id: gbp.id, rate: 0.77)
us_e2 = ExchangeRate.create(base_currency_id: usd.id, converted_currency_id: eur.id, rate: 0.86)
us_e3 = ExchangeRate.create(base_currency_id: usd.id, converted_currency_id: jpy.id, rate: 113)
us_e4 = ExchangeRate.create(base_currency_id: usd.id, converted_currency_id: chi.id, rate: 6.87)

# GBP > EXCHANGE RATES
gb_e1 = ExchangeRate.create(base_currency_id: gbp.id, converted_currency_id: usd.id, rate: 1.2)
gb_e2 = ExchangeRate.create(base_currency_id: gbp.id, converted_currency_id: eur.id, rate: 1.1)
gb_e3 = ExchangeRate.create(base_currency_id: gbp.id, converted_currency_id: jpy.id, rate: 148)
gb_e4 = ExchangeRate.create(base_currency_id: gbp.id, converted_currency_id: chi.id, rate: 8.94)

# EUR > EXCHANGE RATES
eu_e1 = ExchangeRate.create(base_currency_id: eur.id, converted_currency_id: gbp.id, rate: 1.14)
eu_e2 = ExchangeRate.create(base_currency_id: eur.id, converted_currency_id: usd.id, rate: 0.9)
eu_e3 = ExchangeRate.create(base_currency_id: eur.id, converted_currency_id: jpy.id, rate: 131)
eu_e4 = ExchangeRate.create(base_currency_id: eur.id, converted_currency_id: chi.id, rate: 7.93)

# JPY > EXCHANGE RATES
jp_e1 = ExchangeRate.create(base_currency_id: jpy.id, converted_currency_id: gbp.id, rate: 0.006)
jp_e2 = ExchangeRate.create(base_currency_id: jpy.id, converted_currency_id: usd.id, rate: 0.008)
jp_e3 = ExchangeRate.create(base_currency_id: jpy.id, converted_currency_id: eur.id, rate: 0.007)
jp_e4 = ExchangeRate.create(base_currency_id: jpy.id, converted_currency_id: chi.id, rate: 0.060)

# CHI > EXCHANGE RATES
chi_e1 = ExchangeRate.create(base_currency_id: chi.id, converted_currency_id: gbp.id, rate: 0.11)
chi_e2 = ExchangeRate.create(base_currency_id: chi.id, converted_currency_id: usd.id, rate: 0.15)
chi_e3 = ExchangeRate.create(base_currency_id: chi.id, converted_currency_id: eur.id, rate: 0.13)
chi_e4 = ExchangeRate.create(base_currency_id: chi.id, converted_currency_id: jpy.id, rate: 16.5)

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
