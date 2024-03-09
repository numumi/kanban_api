class Column < ApplicationRecord
  belongs_to :board
  has_many :tasks, -> { order(position: :asc) }, dependent: :destroy

  validates :name, :position, presence: true

  def destroy_and_reorder
    ActiveRecord::Base.transaction do
      destroy!
      Column.where(board_id:).order(:position).each_with_index do |column, index|
        column.update!(position: index)
      end
    end
  end

  def self.reorder_positions(column_ids)
    ActiveRecord::Base.transaction do
      column_ids.each_with_index do |id, index|
        column = find(id)
        column.position = index
        column.save!
      end
    end
  end
end
