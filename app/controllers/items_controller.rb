class ItemsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def index

  if params[:user_id]
    user = User.find(params[:user_id])
    items = user.items
    else

      items = Item.all
  end

    render json: items, include: :user
  end

  def show
    item = Item.find(params[:id])
    render json: item
  end

  def create
    item = Item.create(save_params)
    render json: item, except: [:created_at, :updated_at], status: :created

  end
  private

  def save_params
    params.permit(:name, :description, :price, :user_id)
  end
  def render_not_found_response
    render json: { error: "Restaurant not found" }, status: :not_found
  end
end
