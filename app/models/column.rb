class Column < ApplicationRecord
  belongs_to :board
  has_many :tasks, dependent: :destroy

  validates :name, :position, presence: true

  def destroy_and_reorder
    # スタンドアローンモードではトランザクションがサポートされていないため、
    # 手動でのロールバックを行う必要がある
    destroy!
    Column.where(board_id:).asc(:position).each_with_index do |column, index|
      column.update!(position: index)
    end
  end

  def self.reorder_positions(column_ids)
    # スタンドアローンモードではトランザクションがサポートされていないため、
    # 手動でのロールバックを行う必要がある
    column_ids.each_with_index do |id, index|
      column = find(id)
      column.position = index
      column.save!
    end
  end
end
