class ToppingsController < ApplicationController
  before_action :set_topping, only: %i[ edit update destroy ]

  def index
    @toppings = Topping.all
  end

  def new
    @topping = Topping.new
  end

  def create
    @topping = Topping.new(topping_params)
    if @topping.save
      redirect_to toppings_path, notice: "Topping successfully created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @topping.update(topping_params)
      redirect_to toppings_path, notice: "Topping successfully updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @topping.destroy
    redirect_to toppings_path, notice: "Topping successfully deleted!"
  end

  private

  def set_topping
    @topping = Topping.find(params[:id])
  end

  def topping_params
    params.require(:topping).permit(:name)
  end
end
