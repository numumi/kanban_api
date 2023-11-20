class ColumnsController < ApplicationController
  def create
    column = Column.new(column_params)
    column.position = Column.where(board_id: column_params[:board_id]).count
    if column.save
      render json: { message: "カラムが作成されました" }
    else
      render json: column.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    column = Column.find(params[:id])
    if column.update(column_params)
      render json: { message: "カラムが更新されました" }
    else
      render json: column.errors.full_messages, status: :unprocessable_entity
    end
  end

  def move
    Column.reorder_positions(params[:ids])
    render json: { message: "カラムが移動されました" }
  end

  def destroy
    column = Column.find(params[:id])
    if column.destroy_and_reorder
      render json: { message: "カラムが削除されました" }
    else
      render json: column.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def column_params
    params.require(:column).permit(:name, :position, :board_id)
  end
end
