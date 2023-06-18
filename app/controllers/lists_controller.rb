class ListsController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_list, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user, only: [:edit, :update, :destroy]

  def index
    @lists = List.all.where(user: current_user)
  end

  def show
    @category = Category.new
  end

  def new
    @list = List.new
  end

  def edit
  end

  def create
    @list = List.new(list_params)
    @list.user = current_user

    if @list.save
      redirect_to list_url(@list), notice: "La liste a été créée avec succès."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @list.update(list_params)
      redirect_to list_url(@list), notice: "La liste a été mise à jour avec succès."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @list.destroy

    redirect_to lists_url, notice: "La liste a été supprimée avec succès."
  end

  private
    def set_list
      @list = List.find(params[:id])
    end

    def list_params
      params.require(:list).permit(:title)
    end

    def authorize_user
      redirect_to list_url(@list), alert: "Oups! Tu n'as pas le droit" unless @list.user == current_user
    end
end
