require 'rails_helper'

RSpec.describe User, type: :model do
  it "validates" do
    is_expected.to have_many :orders
  end
end
