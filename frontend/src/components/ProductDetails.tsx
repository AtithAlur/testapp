import React from "react";
import { RouteComponentProps, withRouter } from 'react-router';
import {Card, Form, Button} from 'react-bootstrap';
import Container from 'react-bootstrap/Container'
import { Col, Row } from 'react-bootstrap';

import Product from "../types/product";


import './ProductDetails.css';

type ProductDetailsState = {
  quantity: number;
};

class ProductDetails extends React.Component<RouteComponentProps<Product>, ProductDetailsState> {
  state: ProductDetailsState = {
    quantity: 1,
  };

  qunatityChangeHandler(event: React.ChangeEvent<HTMLInputElement>) {
    event.preventDefault();
    this.setState({quantity: Number(event.target.value)});
  }

  checkoutHandler(product: Product) {
    this.props.history.push(`/checkout`, {
      quantity: this.state.quantity,
      product: product
    })
  }

  render() {
    let locationState: any = this.props.location.state;
    
    let product: Product = {
      uuid: locationState.uuid,
      name: locationState.name,
      description: locationState.description,
      price: locationState.price,
      imageUrl: locationState.imageUrl,
      orderLimit: locationState.orderLimit
    } 
    return (
      <Container>
        <Row>
          <Col>
              <Card className='ProductDetails-card'>
                <Card.Header className='ProductDetails-card-header'>{product.name}</Card.Header>
                <Row>
                  <Col lg={3} md={3}>
                    <Card.Img className='ProductDetails-image' src= {product.imageUrl} />
                  </Col>
                  <Col>
                    <Row>
                      <Col>
                        <span className={'ProductDetails-bold'}>Price:</span>{product.price}
                      </Col>
                    </Row>
                    <Row>
                      <Col>
                        <Form inline>
                          <Form.Label className="my-1 mr-2">
                            <span className={'ProductDetails-bold'}>Quantity:</span>
                          </Form.Label>
                          <Form.Control
                            as="select"
                            className="my-1 mr-sm-2"
                            custom
                            onChange = { (e: React.ChangeEvent<HTMLInputElement>) => this.qunatityChangeHandler(e) }
                          >
                            {
                              [...Array(Number(product.orderLimit))].map((_, i) => {
                                return <option key = {i} value={i + 1}>{i + 1}</option>
                              })
                            }
                          </Form.Control>
                          <Button className="my-1 mr-2" onClick = { () => this.checkoutHandler(product) }>
                              Checkout
                          </Button>
                        </Form>
                      </Col>
                    </Row>
                    <Row>
                      <Col>
                        <span className={'ProductDetails-bold'}>Description:</span>
                        {product.description}
                      </Col>
                    </Row>
                  </Col>
                </Row>
              </Card>
          </Col>
        </Row>
      </Container>
    );
  }
}

export default withRouter(ProductDetails);