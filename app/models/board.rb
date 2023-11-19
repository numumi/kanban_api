class Board < ApplicationRecord
  has_one_attached :image
  # has_many :columns, dependent: :destroy
  validates :name, presence: true

  def columns
    Column.where(board_id: id)
  end
end
