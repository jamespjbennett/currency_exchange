FactoryGirl.define do
  factory :exchange_rate do
    rate 1.5
    converted_currency_id 1
    base_currency_id 2
  end
end
