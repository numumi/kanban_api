class Board < ApplicationRecord
  belongs_to :user, optional: true
  has_one_attached :image
  has_many :columns, -> { order(position: :asc) }, dependent: :destroy

  validates :name, presence: true
end
