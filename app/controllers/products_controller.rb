class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    @products = Product.all
  end

  # GET /products/1

  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    thumb_file = params[:product][:thumbnail_file]
    exported_file = params[:product][:exported_file]
    
    @product.label = @product.next_label()
    @product.thumbnail_name = @product.label + File.extname(thumb_file.original_filename)
    @product.exported_name = @product.label + File.extname(exported_file.original_filename)

    respond_to do |format|
      if @product.save && save_files(thumb_file, exported_file)
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def save_files(thumb_file, data_file)
    thumb_exts = [
      ".jpg",
      ".jpeg",
      ".png",
      ".gif",
      ".bmp"
    ]

    base = Rails.root.join("var")
    return save_file(:thumbnail_name, base.join("thumb").join(@product.thumbnail_name).to_s, thumb_file, thumb_exts) &&
      save_file(:exported_name, base.join("data").join(@product.exported_name).to_s, data_file, Genre.where(id: @product.genre_id).pluck(:extension))
  end
  private :save_files

  #TODO nakao 引数渡しすぎもっとスマートに書けるはず
  def save_file(prop, path, file, exts)
    #TODO nakao 連続2回の作成で拡張子チェックをなぜかパスしてしまう
    if exts.include?(File.extname(path)) == false
      #TODO nakao エラー表示の仕方はこれで正しい？
      @product.errors.add(prop, "missing extension : " + path)
      return false
    end
    File.open(path, 'w'){|f| 
      f.write(file.read.force_encoding("UTF-8"))
    }
    return true
  end
  private :save_file

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :genre_id, :category, :thumbnail_file, :exported_file)
    end
end
