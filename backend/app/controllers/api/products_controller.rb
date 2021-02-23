# frozen_string_literal: true

module Api
  class ProductsController < ApplicationController
    include Response
    include ExceptionHandler

    def index
      products = Product.includes([:prices]).all
      json_response({ products: products })
    end
  end
end
