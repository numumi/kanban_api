class BoardsController < SecuredController
  skip_before_action :authorize_request
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
    board_data = Board.includes(columns: :tasks).find(params[:id]).as_json(include: { columns: { only: [:id, :name] } }, only: [:id, :name])
    render json: board_data
  end
end
