class ProductsController < ApplicationController
  def index
    @products = Product.all.with_attached_image
  end

  def show
    product
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    # pp @product #imprimir @producto con los parametros enviados en el form
    if @product.save
      redirect_to products_path, notice: t('.created')
    else
      render :new, status: :unprocessable_entity # devuelve un status 422 422 (Unprocessable Content)
    end
  end

  def edit
    product
  end

  def update
    if product.update(product_params)
      redirect_to products_path, notice: t('.updated')
    else
      render :edit, status: :unprocessable_entity # devuelve un status 422 (Unprocessable Content)
    end
  end

  def destroy
    product.destroy
    redirect_to products_path, notice: t('.destroyed')
  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :price, :image)
  end

  def product
    @product = Product.find(params[:id])
  end
end
