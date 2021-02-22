export type Address = {
  street1: string,
  street2: string,
  city: string,
  state: string,
  zip: string
}

export type Payment = {
  ccNum: string,
  exp: string,
}

export type FormType = {
  backendError: string
}

type OrderDetails = {
  firstName: string,
  lastName: string,
  email: string,
  phone: string,
  total: string,
  quantity: number,
  address: Address,
  payment: Payment,
}


export type OrderFormType = FormType & OrderDetails & Address & Payment;
export default OrderDetails;