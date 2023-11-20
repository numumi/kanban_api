class TasksController < ApplicationController
  def show
    task = Task.find(params[:id])
    render json: task
  end

  def update
    task = Task.find(params[:id])
    if task.update(name: params[:name], description: params[:description])
      render json: { message: "タスクが更新されました" }
    else
      render json: { error: task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def move
    Task.reorder_positions(params[:ids])
    render json: { message: "タスクが移動されました" }
  end

  def destroy
    task = Task.find(params[:id])
    if task.destroy_and_reorder
      render json: { message: "タスクが削除されました" }
    else
      render json: task.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :position)
  end
end
