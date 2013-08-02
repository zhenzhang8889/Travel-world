# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :referto do
    from_id 1
    to_id 1
    referable_id 1
    referable_type "MyString"
  end
end
