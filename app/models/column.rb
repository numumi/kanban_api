class Column
  include Mongoid::Document
  include Mongoid::Timestamps
  embeds_many :tasks

  field :name, type: String
  field :position, type: Integer
  field :board_id, type: Integer

  validates :name, :board_id, :position, presence: true

  def board
    Board.find(board_id)
  end

  def destroy_and_reorder
    board = self.board
    ActiveRecord::Base.transaction do
      self.destroy!
      board.columns.order(:position).each_with_index do |column, index|
        column.update!(position: index)
      end
    end
  end

  def reorder_positions(column_ids)
    ActiveRecord::Base.transaction do
      column_ids.each_with_index do |id, index|
        column = self.find(id)
        column.position = index
        column.save!
      end
    end
  end
end
