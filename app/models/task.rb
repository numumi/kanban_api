class Task
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :description, type: String
  field :position, type: Integer

  embedded_in :column

  validates :name, :position, presence: true

  def destroy_and_reorder
    column = self.column
    ActiveRecord::Base.transaction do
      self.destroy!
      column.tasks.order(:position).each_with_index do |task, index|
        task.update!(position: index)
      end
    end
  end

  def reorder_positions(task_ids)
    ActiveRecord::Base.transaction do
      task_ids.each_with_index do |id, index|
        task = self.find(id)
        task.position = index
        task.save!
      end
    end
  end
end
