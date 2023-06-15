class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category, only: [:edit, :update, :destroy]
  before_action :set_list, only: [:new, :create, :edit, :update, :destroy]
  before_action :authorize_user

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    @category.list_id = @list.id

    if @category.save
      redirect_to list_url(@list), notice: "Category was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      redirect_to list_url(@list), notice: "Category was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @category.destroy

    redirect_to list_url(@list), notice: "Category was successfully destroyed."
  end

  private
    def set_list
      @list = List.find(params[:list_id])
    end

    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:name, :emojie)
    end

    def authorize_user
      redirect_to list_url(@list), alert: "You can't do that." unless @list.user == current_user
    end
end
