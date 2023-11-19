class BoardsController < ApplicationController
  def index
    @boards = Board.with_attached_image.all
    boards_with_image_urls = @boards.map do |board|
      {
        id: board.id,
        name: board.name,
        image: board.image.attached? ? rails_blob_url(board.image) : nil
      }
    end
    render json: boards_with_image_urls
  end

  def show
    @board = Board.find(params[:id])
    board_data = {
      id: @board.id,
      name: @board.name,
      image: @board.image.attached? ? rails_blob_url(@board.image) : nil,
      columns: @board.columns.asc(:position).map do |column|
        {
          name: column.name,
          tasks: column.tasks.asc(:position).map do |task|
            {
              name: task.name,
              description: task.description
            }
          end
        }
      end
    }
    render json: board_data
  end
end
