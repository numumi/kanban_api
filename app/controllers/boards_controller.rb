class BoardsController < SecuredController
  # skip_before_action :authorize_request, only: [:index]
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
          id: column.id,
          name: column.name,
          board_id: column.board.id,
          tasks: column.tasks.asc(:position).map do |task|
            {
              id: task.id,
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
