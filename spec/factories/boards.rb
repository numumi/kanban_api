FactoryBot.define do
  factory :board do
    name { Faker::Lorem.word }
    image { Rack::Test::UploadedFile.new(Rails.root.join('public', 'images', 'wood-texture_00003.jpg'), 'image/jpeg') }
  
    after(:create) do |board|
      create_list(:column, 3, board: board)
    end
  end
end
