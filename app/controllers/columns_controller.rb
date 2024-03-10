class ColumnsController < ApplicationController
  def create
    column = Column.new(column_params)
    column.position = Column.next_position(parent_id: column.board_id, parent_attribute: :board_id)
    if column.save
      render json:  {id: column.id.to_s, message: 'カラムが作成されました' }
    else
      render json: column.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    column = Column.find(params[:id])
    if column.update(column_params)
      render json: { message: 'カラムが更新されました' }
    else
      render json: column.errors.full_messages, status: :unprocessable_entity
    end
  end

  def move
    Column.reorder_positions(params[:ids])
    render json: { message: 'カラムが移動されました' }
  end

  def destroy
    column = Column.find(params[:id])
    if column.destroy_and_reorder
      render json: { message: 'カラムが削除されました' }
    else
      render json: column.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def column_params
    params.require(:column).permit(:name, :position, :board_id)
  end
end
