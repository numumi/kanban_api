class Task < ApplicationRecord
  belongs_to :column

  validates :name, :position, presence: true

  # タスクの削除と空いた並び順を整列
  def destroy_and_reorder
    # スタンドアローンモードではトランザクションがサポートされていないため、
    # 手動でのロールバックを行う必要がある
    destroy!
    column.tasks.asc(:position).each_with_index do |task, index|
      task.update!(position: index)
    end
  end

  # タスクの整列
  def reorder(position, column)
    # 移動先カラムにタスクがある場合は、そのタスクより後ろのタスクのpositionを+1する
    # gteはgreater than or equal toの略で、MongoDBの検索条件の一つ
    column.tasks.where(:id.ne => id).asc(:position).each_with_index do |task, index|
      task.update!(position: index)
    end
    column.tasks.where(:position.gte => position).find_each do |task|
      if task
        task.inc(position: 1)
        task.save!
      end
    end
  end

  def reorder_positions(position, source_column_id, destination_column_id)
    # スタンドアローンモードではトランザクションがサポートされていないため、
    # 手動でのロールバックを行う必要がある
    column = Column.find(destination_column_id)
    reorder(position, column)
    if source_column_id == destination_column_id
      update(position:)
      return nil
    else
      new_task = column.tasks.create!(attributes.except('_id', 'created_at', 'updated_at')
                                .merge(position:))
      destroy_and_reorder
      return new_task
    end
  end
end
