class ColumnsController < ApplicationController
  def create
    column = Column.new(column_params)
    column.position = Column.where(board_id: column_params[:board_id]).count
    if column.save
      render json: column, status: :created
    else
      render json: column.errors, status: :unprocessable_entity
    end
  end

  def update
    column = Column.find(params[:id])
    if column.update(column_params)
      render json: column
    else
      render json: column.errors, status: :unprocessable_entity
    end
  end

  def move
    Column.reorder_positions(params[:ids])
    render json: { message: "Columns moved successfully" }
  end

  def destroy
    column = Column.find(params[:id])
    if column.destroy_and_reorder
      render json: column
    else
      render json: column.errors, status: :unprocessable_entity
    end
  end

  private

  def column_params
    params.require(:column).permit(:name, :position, :board_id)
  end
end
