FactoryBot.define do
  factory :column do
    name { Faker::Lorem.word }
    sequence(:position) { |n| n }
    association :board
    lock_version { 0 }

    after(:create) do |column|
      create_list(:task, 3, column: column)
    end
  end
end
