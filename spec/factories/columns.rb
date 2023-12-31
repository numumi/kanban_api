FactoryBot.define do
  factory :column do
    name { Faker::Lorem.word }
    sequence(:position) { |n| n }
    lock_version { 0 }
    board

    after(:create) do |column|
      create_list(:task, 3, column:)
    end
  end
end
