import React from "react";
import {Card, Form, Button} from 'react-bootstrap';
import { Col } from 'react-bootstrap';
import { FormikProps, withFormik } from 'formik';
import * as yup from 'yup';

import Product from "../types/product";
import {OrderFormType} from "../types/order_details";
import States from '../data/states'
import Backend from "../actions/backend";

import './OrderForm.css';

const digitsOnly = (value: any) => /^\d+$/.test(value);
const expiryFmt = (value: any) => /^\d{2}\/\d{4}$/.test(value);
const schema = yup.object().shape({
  firstName: yup.string().required(),
  lastName: yup.string().required(),
  email: yup.string().required().email(),
  phone: yup.string().required().min(10).max(10).test('Digits only', 'The field should have digits only', digitsOnly),
  street1: yup.string().required(),
  city: yup.string().required(),
  zip: yup.string().required().min(5).max(5).test('Digits only', 'The field should have digits only', digitsOnly),
  ccNum: yup.string().required().min(16).max(20).test('Digits only', 'The field should have digits only', digitsOnly),
  exp: yup.string().required().min(7).max(7).test('Expiry format', 'Expected format MM/YYYY', expiryFmt),
});

type OtherProps = {
  product: Product,
  handleBack: (event: React.MouseEvent<HTMLButtonElement>) => void
}

const OrderInnerForm = (props:  OtherProps & FormikProps<OrderFormType>) => {
  const { values, errors, isSubmitting, handleChange, handleSubmit, handleBack} = props;
  return(
    <Form noValidate onSubmit={handleSubmit}>
            <Card className='OrderForm-card'>
              <Card.Header className='OrderForm-card-header'>Order Details:</Card.Header>
              <Card.Body>
                <Form.Group controlId="product">
                  <Form.Label><span className='OrderForm-bold'>Product: </span></Form.Label>
                  <Form.Label>&nbsp;{props.product.name}</Form.Label>
                </Form.Group>
                <Form.Group controlId="quantity">
                  <Form.Label><span className='OrderForm-bold'>Quantity:</span></Form.Label>
                  <Form.Label>&nbsp;{values.quantity}</Form.Label>
                </Form.Group>
                <Form.Group controlId="total">
                  <Form.Label><span className='OrderForm-bold'>Total:</span> </Form.Label>
                  <Form.Label>&nbsp;{String(values.quantity * parseFloat(props.product.price))}</Form.Label>
                </Form.Group>
              </Card.Body>
            </Card>
            <Card className='OrderForm-card'>
              <Card.Header className='OrderForm-card-header'>User Details:</Card.Header>
              <Card.Body>
                <Form.Row>
                  <Form.Group as={Col} controlId="first_name">
                    <Form.Label>First Name</Form.Label>
                    <Form.Control
                      type="text"
                      name="firstName"
                      value={values.firstName}
                      onChange={handleChange}
                      isInvalid={!!errors.firstName}
                      maxLength={50}
                      size = 'sm'
                    />
                    <Form.Control.Feedback type="invalid">
                      {errors.firstName}
                    </Form.Control.Feedback>
                  </Form.Group>

                  <Form.Group as={Col} controlId="last_name">
                    <Form.Label>Last Name</Form.Label>
                    <Form.Control
                      type="text"
                      name="lastName"
                      value={values.lastName}
                      onChange={handleChange}
                      isInvalid={!!errors.lastName}
                      maxLength={50}
                      size = 'sm'
                      />
                      <Form.Control.Feedback type="invalid">
                        {errors.lastName}
                      </Form.Control.Feedback>
                  </Form.Group>
                </Form.Row>

                <Form.Group controlId="email">
                  <Form.Label>Email Id</Form.Label>
                  <Form.Control 
                  maxLength={50}
                  type= 'email'
                  placeholder='@gmail.com'
                  name="email"
                  value={values.email}
                  onChange={handleChange}
                  isInvalid={!!errors.email}
                  size = 'sm'
                  />
                  <Form.Control.Feedback type="invalid">
                        {errors.email}
                  </Form.Control.Feedback>
                </Form.Group>

                <Form.Group controlId="phone">
                  <Form.Label>Phone</Form.Label>
                  <Form.Control
                   maxLength={10}
                   name="phone"
                   value={values.phone}
                   onChange={handleChange}
                   isInvalid={!!errors.phone}
                   placeholder='10 digits'
                   size = 'sm'
                  />
                  <Form.Control.Feedback type="invalid">
                    {errors.phone}
                  </Form.Control.Feedback>
                </Form.Group>
              </Card.Body>
            </Card>

            <Card className='OrderForm-card'>
              <Card.Header className='OrderForm-card-header'>Address:</Card.Header>
              <Card.Body>
                <Form.Group controlId="street1">
                  <Form.Label>Street 1</Form.Label>
                  <Form.Control
                   maxLength={50}
                   placeholder="Street name"
                   name="street1"
                   value={values.street1}
                   onChange={handleChange}
                   isInvalid={!!errors.street1}
                   size = 'sm'
                  />
                  <Form.Control.Feedback type="invalid">
                    {errors.street1}
                  </Form.Control.Feedback>
                </Form.Group>

                <Form.Group controlId="street2">
                  <Form.Label>Street 2</Form.Label>
                  <Form.Control
                   maxLength={50}
                   placeholder="Apt, Suite"
                   name="street2"
                   value={values.street2}
                   onChange={handleChange}
                   isInvalid={!!errors.street2}
                   size = 'sm'
                  />
                  <Form.Control.Feedback type="invalid">
                    {errors.street2}
                  </Form.Control.Feedback>
                </Form.Group>

                <Form.Row>
                  <Form.Group as={Col} controlId="city">
                    <Form.Label>City</Form.Label>
                    <Form.Control
                      maxLength={20}
                      name="city"
                      value={values.city}
                      onChange={handleChange}
                      isInvalid={!!errors.city}
                      size = 'sm'
                    />
                    <Form.Control.Feedback type="invalid">
                      {errors.city}
                    </Form.Control.Feedback>
                  </Form.Group>

                  <Form.Group as={Col} controlId="state">
                    <Form.Label>State</Form.Label>
                    <Form.Control
                     as="select"
                     size = 'sm'
                     name="state"
                     value={values.state}
                     onChange={handleChange}
                     defaultValue='AL'
                     >
                      {
                        States.map((state, index) => {
                          return <option key={index+1} value={state.abbreviation}>{ state.abbreviation }</option>
                        })
                      }
                    </Form.Control>
                  </Form.Group>

                  <Form.Group as={Col} controlId="zip">
                    <Form.Label>Zip</Form.Label>
                    <Form.Control
                      maxLength={6}
                      name="zip"
                      value={values.zip}
                      onChange={handleChange}
                      isInvalid={!!errors.zip}
                      size = 'sm'
                    />
                    <Form.Control.Feedback type="invalid">
                      {errors.zip}
                    </Form.Control.Feedback>
                  </Form.Group>
                </Form.Row>
              </Card.Body>
            </Card>
            <Card className='OrderForm-card'>
              <Card.Header className='OrderForm-card-header'>Payment:</Card.Header>
              <Card.Body>
                <Form.Group controlId="credit_card">
                  <Form.Label>Credit Card Number</Form.Label>
                  <Form.Control
                    maxLength={20}
                    name="ccNum"
                    value={values.ccNum}
                    onChange={handleChange}
                    isInvalid={!!errors.ccNum}
                    size = 'sm'
                  />
                  <Form.Control.Feedback type="invalid">
                    {errors.ccNum}
                  </Form.Control.Feedback>
                </Form.Group>
                <Form.Group controlId="expiry">
                  <Form.Label>Expiry</Form.Label>
                  <Form.Control
                    maxLength={7}
                    placeholder='MM/YYYY'
                    name="exp"
                    value={values.exp}
                    onChange={handleChange}
                    isInvalid={!!errors.exp}
                    size = 'sm'
                  />
                  <Form.Control.Feedback type="invalid">
                    {errors.exp}
                  </Form.Control.Feedback>
                </Form.Group>
              </Card.Body>
            </Card>
            <div className='OrderForm-buttons'>
              <Button variant="secondary" onClick={handleBack}>
                Back
              </Button>
              <Button variant="primary" type="submit" disabled={isSubmitting}>
                Submit
              </Button>
            </div>
          </Form>
  );
}

interface OrderFormProps {
  product: Product,
  quantity: number,
  handleBack: (event: React.MouseEvent<HTMLButtonElement>) => void,
  handleSuccess: (orderUuid: string) => void,
  handleError: (errorMessage: string) => void,
}

const scrollToTop = () => {
  window.scrollTo(0, 0)
};

const OrderForm = withFormik<OrderFormProps, OrderFormType>({
  validationSchema: schema,
  handleSubmit: (values, {props, setSubmitting}) => {
    let orderForm: OrderFormType = values;
    orderForm.total = String(props.quantity * parseFloat(props.product.price));
    Backend.submitOrder(orderForm).then(response => {
      setSubmitting(false)
      if(response.status === 201){
        props.handleSuccess(response.data?.uid)
      } else {
        props.handleError(response.data.message);
        scrollToTop();
      }
    }).catch(error => {
      let errorMessage = 'Something went wrong placing the order';
      if(error.response?.data?.message){
        errorMessage = error.response.data.message;
      }
      setSubmitting(false)
      props.handleError(errorMessage);
      scrollToTop();
    });
  },
})(OrderInnerForm);

export default OrderForm;

