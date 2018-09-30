require 'rails_helper'

RSpec.describe Order, type: :model do
  it "validates" do
    is_expected.to belong_to :quotation
    is_expected.to belong_to :user
    is_expected.to validate_presence_of(:user_id)
    is_expected.to validate_presence_of(:quotation_id)
  end

end
