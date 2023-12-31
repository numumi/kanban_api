FactoryBot.define do
  factory :column do
    name { Faker::Lorem.word }
    sequence(:position) { |n| n }
    board
    lock_version { 0 }

    after(:create) do |column|
      create_list(:task, 3, column:)
    end
  end
end
