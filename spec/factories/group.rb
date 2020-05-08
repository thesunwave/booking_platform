FactoryBot.define do
  factory :group do
    course
    start_date { Date.current }
  end
end
