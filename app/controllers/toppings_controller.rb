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
      flash.now[:alert] = "Failed to create topping."
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @topping.update(topping_params)
      redirect_to toppings_path, notice: "Topping successfully updated!"
    else
      flash.now[:alert] = "Failed to update topping."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @topping.destroy
      redirect_to toppings_path, notice: "Topping successfully deleted!", status: :see_other
    else
      redirect_to toppings_path, alert: @topping.errors.full_messages.to_sentence, status: :see_other
    end
  end

  private

  def set_topping
    @topping = Topping.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to toppings_path, alert: "Topping not found or already deleted."
  end

  def topping_params
    params.require(:topping).permit(:name)
  end
end
