class PizzasController < ApplicationController
  before_action :require_login
  before_action :set_pizza, only: %i[ edit update destroy ]

  def index
    @pizzas = Pizza.includes(:toppings).all
  end

  def new
    @pizza = Pizza.new
    @toppings = Topping.all
  end

  def create
    @pizza = Pizza.new(pizza_params)
    @toppings = Topping.all

    if @pizza.save
      redirect_to pizzas_path, notice: "Pizza successfully created!"
    else
      flash.now[:alert] = "Failed to create pizza."
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @toppings = Topping.all
  end

  def update
    @toppings = Topping.all

    if @pizza.update(pizza_params)
      redirect_to pizzas_path, notice: "Pizza successfully updated!"
    else
      flash.now[:alert] = "Could not update pizza."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @pizza.destroy
    redirect_to pizzas_path, notice: "Pizza successfully deleted!", status: :see_other
  end

  private

  def set_pizza
    @pizza = Pizza.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to pizzas_path, alert: "Pizza not found or already deleted."
  end

  def pizza_params
    params.require(:pizza).permit(:name, :description, topping_ids: [])
  end
end
