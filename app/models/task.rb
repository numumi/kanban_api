class Task < ApplicationRecord
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
    # まず、現在のタスクを除いて、カラム内のタスクのpositionを再設定します
    column.tasks.where.not(id: id).order(:position).each_with_index do |task, index|
      task.update!(position: index + 1) 
    end
  
    # 指定された位置がある場合、その位置以降のタスクのpositionを1つずつ増やします
    if new_position
      # 位置の降順でタスクを取得して、後ろから順に更新
      column.tasks.where('position <= ?', new_position).order(position: :asc).each do |task|
        task.update!(position: task.position + 1) # positionを増加させて保存します
      end
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
