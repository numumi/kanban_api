class Board < ApplicationRecord
  belongs_to :user, optional: true
  has_one_attached :image
  has_many :columns, -> { order(position: :asc) }, dependent: :destroy

  validates :name, presence: true

  # 後でserializerを使う方法に変更
  def with_details
    as_json(
      include: {
        columns: {
          only: [:id, :name, :position, :board_id],
          include: {
            tasks: {
              only: [:id, :name, :position, :column_id]
            }
          }
        },
      },
      only: [:id, :name]
    )
  end
end
