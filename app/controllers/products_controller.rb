class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    # pp @product #imprimir @producto con los parametros enviados en el form
    if @product.save
      redirect_to products_path, notice: 'Producto agregado correctamente'
    else
      render :new, status: :unprocessable_entity # devuelve un status 422 422 (Unprocessable Content)
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])

    if @product.update(product_params)
      redirect_to products_path, notice: 'Producto actualizado correctamente'
    else
      render :edit, status: :unprocessable_entity # devuelve un status 422 (Unprocessable Content)
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    redirect_to products_path, notice: 'Producto eliminado correctamente'
  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :price, :image)
  end
end
