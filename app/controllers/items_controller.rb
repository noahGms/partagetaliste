class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :destroy]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :set_list, only: [:new, :create, :edit, :update, :destroy]
  before_action :authorize_user, only: [:edit, :update, :destroy]

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.list_id = @list.id

    if @item.save
      redirect_to list_url(@list), notice: "L'item a été créé avec succès."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to list_url(@list), notice: "L'item a été mis à jour avec succès."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy

    redirect_to list_url(@list), notice: "L'item a été supprimé avec succès."
  end

  private
    def set_item
      @item = Item.find(params[:id])
    end

    def item_params
      params.require(:item).permit(:name, :category_id, :username, :quantity)
    end

    def set_list
      @list = List.find(params[:list_id])
    end

  def authorize_user
    redirect_to list_url(@list), alert: "Oups! Tu n'as pas le droit" unless @list.user == current_user
  end
end
