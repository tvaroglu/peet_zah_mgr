class PizzasController < ApplicationController
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
    if @pizza.save
      redirect_to pizzas_path, notice: "Pizza successfully created!"
    else
      @toppings = Topping.all
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @toppings = Topping.all
  end

  def update
    if @pizza.update(pizza_params)
      redirect_to pizzas_path, notice: "Pizza successfully updated!"
    else
      @toppings = Topping.all
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @pizza.destroy
    redirect_to pizzas_path, notice: "Pizza successfully deleted!"
  end

  private

  def set_pizza
    @pizza = Pizza.find(params[:id])
  end

  def pizza_params
    params.require(:pizza).permit(:name, :description, topping_ids: [])
  end
end
