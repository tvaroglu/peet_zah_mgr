class ToppingsController < ApplicationController
  before_action :set_topping, only: %i[ show edit update destroy ]

  # GET /toppings or /toppings.json
  def index
    @toppings = Topping.all
  end

  # GET /toppings/1 or /toppings/1.json
  def show
  end

  # GET /toppings/new
  def new
    @topping = Topping.new
  end

  # GET /toppings/1/edit
  def edit
  end

  # POST /toppings or /toppings.json
  def create
    @topping = Topping.new(topping_params)

    respond_to do |format|
      if @topping.save
        format.html { redirect_to @topping, notice: "Topping was successfully created." }
        format.json { render :show, status: :created, location: @topping }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @topping.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /toppings/1 or /toppings/1.json
  def update
    respond_to do |format|
      if @topping.update(topping_params)
        format.html { redirect_to @topping, notice: "Topping was successfully updated." }
        format.json { render :show, status: :ok, location: @topping }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @topping.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /toppings/1 or /toppings/1.json
  def destroy
    @topping.destroy!

    respond_to do |format|
      format.html { redirect_to toppings_path, status: :see_other, notice: "Topping was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_topping
      @topping = Topping.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def topping_params
      params.expect(topping: [ :name ])
    end
end
