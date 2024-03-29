class Task < ApplicationRecord
  include Positionable
  belongs_to :column

  validates :name, :position, presence: true

  # タスクの削除と空いた並び順を整列
  def destroy_and_reorder
    ActiveRecord::Base.transaction do
      destroy!
      column.tasks.order(:position).each_with_index do |task, index|
        task.update!(position: index)
      end
    end
  end

  # タスクの整列
  def reorder(new_position = nil, column)
    if new_position && new_position <= column.tasks.count
      # 位置の降順でタスクを取得して、後ろから順に更新
      column.tasks.where('position >= ?', new_position).where.not(id: id).update_all('position = position + 1')
    else
      column.tasks.update_all('position = position + 1')
    end
  end

  def reorder_positions(position, source_column_id, destination_column_id)
    destination_column = Column.find(destination_column_id)

    ActiveRecord::Base.transaction do
      reorder(position, destination_column)
      if source_column_id == destination_column_id
        update!(position: position)
      else
        source_column = Column.find(source_column_id)
        update!(column: destination_column, position: position)
        reorder(nil, source_column)
      end
    end
  end
end
