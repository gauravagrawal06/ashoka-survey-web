FactoryGirl.define do
  factory :option do
    question
    sequence(:content) { |n| "This is option number #{n}" }
    sequence(:order_number, 1000)
  end
end
