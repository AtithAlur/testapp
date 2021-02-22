class Api::ProductsController < ApplicationController
    include Response
    include ExceptionHandler

  def index
    products = Product.includes([:prices]).all
    json_response({products: products})
  end
end
