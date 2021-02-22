import axios from 'axios';

import OrderDetails, { OrderFormType } from '../types/order_details';

const BACKEND_ENDPOINT = 'http://localhost:8080/api'
const GET_PRODUCTS_ENDPOINT = BACKEND_ENDPOINT + '/products'
const POST_ORDER_ENDPOINT = BACKEND_ENDPOINT + '/magic'

class Backend {
  static fetchAllProducts() {
    console.log(GET_PRODUCTS_ENDPOINT)
    return axios.get(GET_PRODUCTS_ENDPOINT)
  }

  static submitOrder(orderForm: OrderFormType) {
    let orderDetails: OrderDetails = {
      firstName: orderForm.firstName,
      lastName: orderForm.lastName,
      email: orderForm.email,
      phone: orderForm.phone,
      total: orderForm.total,
      quantity: orderForm.quantity,
      address: {
        street1: orderForm.street1,
        street2: orderForm.street2,
        city: orderForm.city,
        state: orderForm.state,
        zip: orderForm.zip
      },
      payment: {
        ccNum: orderForm.ccNum,
        exp: orderForm.exp
      },
    };

    return axios.post(POST_ORDER_ENDPOINT, orderDetails)
  }
}

export default Backend;