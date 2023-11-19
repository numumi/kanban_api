class Column
  include Mongoid::Document
  include Mongoid::Timestamps
  embeds_many :tasks

  field :name, type: String
  field :position, type: Integer
  field :board_id, type: Integer
  validates :name, presence: true

  def board
    Board.find(board_id)
  end
end
