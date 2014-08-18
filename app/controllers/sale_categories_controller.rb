class SaleCategoriesController < ApplicationController
  before_action :set_sale_category, only: [:show, :edit, :update, :destroy]

  # GET /sale_categories
  # GET /sale_categories.json
  def index
    @sale_categories = SaleCategory.all
  end

  # GET /sale_categories/1
  # GET /sale_categories/1.json
  def show
  end

  # GET /sale_categories/new
  def new
    @sale_category = SaleCategory.new
  end

  # GET /sale_categories/1/edit
  def edit
  end

  # POST /sale_categories
  # POST /sale_categories.json
  def create
    @sale_category = SaleCategory.new(sale_category_params)

    respond_to do |format|
      if @sale_category.save
        format.html { redirect_to @sale_category, notice: 'Sale category was successfully created.' }
        format.json { render :show, status: :created, location: @sale_category }
      else
        format.html { render :new }
        format.json { render json: @sale_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sale_categories/1
  # PATCH/PUT /sale_categories/1.json
  def update
    respond_to do |format|
      if @sale_category.update(sale_category_params)
        format.html { redirect_to @sale_category, notice: 'Sale category was successfully updated.' }
        format.json { render :show, status: :ok, location: @sale_category }
      else
        format.html { render :edit }
        format.json { render json: @sale_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sale_categories/1
  # DELETE /sale_categories/1.json
  def destroy
    @sale_category.destroy
    respond_to do |format|
      format.html { redirect_to sale_categories_url, notice: 'Sale category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sale_category
      @sale_category = SaleCategory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sale_category_params
      params.require(:sale_category).permit(:name, :label)
    end
end
