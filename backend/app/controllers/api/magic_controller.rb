# frozen_string_literal: true

module Api
  class MagicController < ApplicationController
    include Response
    include ExceptionHandler

    def create
      product = Product.find_magic_potion!
      user_attrs = user_attributes(magic_post_params)
      order_attrs = order_attributes(product.uuid, magic_post_params)

      user = User.find_by(email: user_attrs[:email])
      user ||= User.create_user!(user_attrs)
      order = Order.create_order!(user, order_attrs)
      json_response({ uid: order.uuid }, :created)
    end

    def show
      order = Order.includes(%i[user credit_card address
                                order_products products])
                   .find_by!(uuid: params[:uid])
      json_response(order, :ok)
    end

    def update
      patch_params = magic_patch_params
      order = Order.find_by!(uuid: patch_params[:uid])
      Order.update_order!(order, patch_params)
    end

    def destroy
      order = Order.find_by!(uuid: params[:uid])
      order.destroy!
    end

    private

    def magic_post_params
      params.permit(:email, :firstName, :lastName, :phone, :quantity, :total,
                    address: %i[street1 street2 city state zip],
                    payment: %i[ccNum exp])
    end

    def magic_patch_params
      params.permit(:uid, :fulfilled)
    end

    def user_attributes(attrs)
      {
        email: attrs.delete(:email),
        first_name: attrs.delete(:firstName),
        last_name: attrs.delete(:lastName),
        phone_number: attrs.delete(:phone)
      }
    end

    def order_attributes(product_uuid, attrs)
      {
        total: attrs[:total],
        address: address_attrs(attrs[:address]),
        credit_card: credit_card_attrs(attrs[:payment]),
        products: product_attrs(product_uuid, attrs)
      }
    end

    def address_attrs(attrs)
      {
        address_line1: attrs[:street1],
        address_line2: attrs[:street2],
        city: attrs[:city],
        state: attrs[:state],
        zip: attrs[:zip]
      }
    end

    def credit_card_attrs(attrs)
      {
        card_number: attrs[:ccNum],
        expiry: attrs[:exp]
      }
    end

    def product_attrs(product_uuid, attrs)
      [{
        uuid: product_uuid,
        quantity: attrs[:quantity]
      }]
    end
  end
end
