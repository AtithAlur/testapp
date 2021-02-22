import React from "react";
import { RouteComponentProps, withRouter } from 'react-router';
import Container from 'react-bootstrap/Container'

import './Checkout.css';

import OrderForm from './OrderForm';
import Product from '../types/product';
import { Alert } from "react-bootstrap";

type CheckoutProps = {
};

type CheckoutState = {
  quantity: number,
  product: Product,
  orderUuid: string | undefined,
  errorMessage: string | undefined,
};

class Checkout extends React.Component<RouteComponentProps<CheckoutProps>, CheckoutState> {
  constructor(props: RouteComponentProps) {
    super(props);

    let locationState: any = props.location.state;
    this.state = {
      quantity: locationState.quantity,
      product: locationState.product,
      orderUuid: undefined,
      errorMessage: undefined
    };
  }

  handleSuccess(orderUuid: string) {
    if(orderUuid){
      this.setState({orderUuid: orderUuid, errorMessage: undefined})
    }
  }


  handleError(errorMessage: string) {
    if(errorMessage){
      this.setState({errorMessage: errorMessage, orderUuid: undefined})
    }
  }

  handleBack(event: React.MouseEvent<HTMLButtonElement>) {
    event.preventDefault();
    this.props.history.goBack();
  }

  render() {
    return(
      <Container>
        {
          this.state.errorMessage && (
            <Alert variant={'danger'}>
                {this.state.errorMessage}
            </Alert>
          )
        }
        {
          this.state.orderUuid !== undefined ? 
            (
              <Alert variant={'success'}>
                <div>Order Successfull!</div>
                <div>Order Id: {this.state.orderUuid}</div>
              </Alert>
            )
            :
            (
              <OrderForm 
                quantity = {this.state.quantity} 
                product = {this.state.product}
                handleBack = { (event: React.MouseEvent<HTMLButtonElement>) => this.handleBack(event) }
                handleSuccess = { (orderUuid: string) => this.handleSuccess(orderUuid) }
                handleError = { (errorMessage: string) => this.handleError(errorMessage) }
              />
            )
        }
        
        <br/>
      </Container>
    ) 
  }
}

export default withRouter(Checkout);