FactoryBot.define do
  factory :task do
    name { Faker::Lorem.sentence(word_count: 3) }
    description { Faker::Lorem.paragraph(sentence_count: 2) }
    sequence(:position) { |n| n }
    lock_version { 0 }
    column
  end
end
