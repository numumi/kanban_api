class TasksController < ApplicationController
  def show
    task = Task.find(params[:id])
    render json: task
  end
  def create
    task = Task.new(task_params)
    task.position = column.tasks.count
    if task.save
      render json: { id: task.id, message: 'タスクが作成されました' }
    else
      render json: task.errors.full_messages, status: :unprocessable_entity
    end
  end


  def update
    task = Task.find(params[:id])
    if task.update(name: params[:name], description: params[:description])
      render json: { message: 'タスクが更新されました' }
    else
      render json: { error: task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def move
    task = Task.find(params[:id])
    if task.reorder_positions(params[:position], params[:source_column_id], params[:destination_column_id])
      render json: { message: 'タスクが移動されました' }
    else
      render json: { error: task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    task = Task.find(params[:id])
    if task.destroy_and_reorder
      render json: { message: 'タスクが削除されました' }
    else
      render json: task.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :position).merge(column_id: params[:column_id])
  end
end
