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
    # スタンドアローンモードではトランザクションがサポートされていないため、
    # 手動でのロールバックを行う必要がある
    self.destroy!
    Column.where(board_id: self.board_id).asc(:position).each_with_index do |column, index|
      column.update!(position: index)
    end
  end

  def self.reorder_positions(column_ids)
    # スタンドアローンモードではトランザクションがサポートされていないため、
    # 手動でのロールバックを行う必要がある
    column_ids.each_with_index do |id, index|
      column = self.find(id)
      column.position = index
      column.save!
    end
  end
end
