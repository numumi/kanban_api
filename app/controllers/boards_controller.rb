class BoardsController < ApplicationController
  
  def index
    @boards = Board.with_attached_image.all
    boards_with_image_urls = @boards.map do |board|
      {
        id: board.id,
        name: board.name,
        image: image_url(board.image)
      }
    end
    render json: boards_with_image_urls
  end

  def show
    board = Board.includes(columns: :tasks).find(params[:id])
    board_data =  board.with_details.merge(image: image_url(board.image))
    render json: board_data
  end

  private

  def image_url(image)
    image.attached? ? rails_blob_url(image) : nil
  end
end
