FactoryBot.define do
  factory :board do
    name { Faker::Lorem.word }
    # image { Rack::Test::UploadedFile.new(Rails.public_path.join('images/wood-texture_00003.jpg'), 'image/jpeg') }
    # after(:build) do |board|
    #   board.image.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'wood-texture_00003.jpg')), filename: 'wood-texture_00003.jpg', content_type: 'image/jpeg')
    # end
    after(:create) do |board|
      # board.image.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'wood-texture_00003.jpg')), filename: 'wood-texture_00003.jpg', content_type: 'image/jpeg')
      # board.image.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'wood-texture_00003.jpg')), filename: 'wood-texture_00003.jpg', content_type: 'image/jpeg')
      create_list(:column, 3, board:)
    end
  end
end
