# CURRENCY EXCHANGE

### An API to allow currency conversion quotations and orders between different foreign currencies. Built as a ruby on rails Api.

### CONFIG
  

 * Ruby 2.5.0
 * Rails 5.2.1

### SET UP

`bundle install` 

` rake db:create db:migrate db:seed`

* Database will be poulated with a selection of exchange rates and currencies.

### TEST

run `rspec` to run all tests

# BASIC USAGE

## Listings

* get `/api/v1/currencies` to view list of currencies and their assosicated exchange rates

* get `/api/v1/currencies/USD` to view single currency and it's assosicated exchange rates

* get `/api/v1/exchange_rates` to view all exchange rates

* get `/api/v1/orders` to view all orders


## Create quotation

* post `/api/v1/quotations` params `based_requested_amount: [float], exchange_rate_id: [valid quotation id]`

## Create order

* post `/api/v1/orders` params `user_id: [valid user id], quotation: [valid quotation id]`

## update exchange rate

* you can update the exchange_rate rate

* patch `api/v1/exchange_rates/[ valid exchange rate id]` params `rate: [float]`

* if exchange_rate rate changes between the time of quotation and conversion of order - it will be be invalid and have to be requoted

## List user orders and available currency

* get `/api/v1/users/[valid user id]` 


# Further work

* integrate with a currency exchange api to get all real rates rather than seeding them

* cron job to reguarly update exhcnage exchange rates

* if calculations and logic gets more complicated - split out into service objects and possible value objects
