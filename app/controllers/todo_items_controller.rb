class TodoItemsController < ApplicationController
  before_action :set_todo_list
  before_action :set_todo_items, except: [:create]
  def create
    @todo_item = @todo_list.todo_items.create(todo_item_params)
    redirect_to @todo_list
  end

  def destroy
    if @todo_item.destroy
      flash[:error] = "Todo List Item Was Deleted"
    else
      flash[:error] = "Todo List Item Could Not Be Deleted."
    end
    redirect_to @todo_list
  end

  def complete
    @todo_item.update_attribute(:completed_at, Time.now)
    redirect_to @todo_list, notice: "Todo Item Completed"
  end

  private

def set_todo_items
    @todo_item = @todo_list.todo_items.find(params[:id])
end

  def set_todo_list
    @todo_list = TodoList.find(params[:todo_list_id])
  end

  def todo_item_params
    params[:todo_item].permit(:content)
  end
end
