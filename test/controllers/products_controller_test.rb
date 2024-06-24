class ProductsControllerTest < ActionDispatch::IntegrationTest
  test 'render a list of products' do
    get products_path

    assert_response :success
    assert_select '.product', 4
  end

  test 'render a detailed product page' do
    get product_path(products(:jabon))

    assert_response :success
    assert_select '.title', 'Jabón Orgánico de Aloe Vera'
    assert_select '.description', 'Jabón suave hecho con ingredientes naturales y aloe vera.'
    assert_select '.price', '5.1 $'
  end

  test 'render a new product form' do
    get new_product_path

    assert_response :success
    assert_select 'form'
  end

  test 'allow to create a new product' do
    post products_path, params: {
      product: {
        title: 'Cepillo de bambu',
        description: 'Cepillos de dientes biodegradables hechos de bambú.',
        price: 3.3
      }
    }

    assert_redirected_to products_path
    assert_equal flash[:notice], 'Producto agregado correctamente'
  end

  test 'does not allow to create a new product with empty fields' do
    post products_path, params: {
      product: {
        title: '',
        description: 'Cepillos de dientes biodegradables hechos de bambú.',
        price: 3
      }
    }

    assert_response :unprocessable_entity
  end

  test 'render an edit product form' do
    get edit_product_path(products(:jabon))

    assert_response :success
    assert_select 'form'
  end

  test 'allow to update a product' do
    patch product_path(products(:jabon)), params: {
      product: {
        # title: 'Jabón Orgánico de AloeVera',
        # description: 'Jabón suave hecho con ingredientes naturales y aloe vera.',
        price: 3
      }
    }

    assert_redirected_to products_path
    assert_equal flash[:notice], 'Producto actualizado correctamente'
  end

  test 'does not allow to update a product' do
    patch product_path(products(:jabon)), params: {
      product: {
        # title: 'Jabón Orgánico de AloeVera',
        # description: 'Jabón suave hecho con ingredientes naturales y aloe vera.',
        price: nil
      }
    }

    assert_response :unprocessable_entity
  end

  test 'allow to delete a product' do
    assert_difference('Product.count', -1) do
      delete product_path(products(:jabon))
    end

    assert_redirected_to products_path
    assert_equal flash[:notice], 'Producto eliminado correctamente'
  end
end
