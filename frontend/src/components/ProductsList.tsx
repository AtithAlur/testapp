import React from "react";
import {CardDeck, Card, Row, Col} from 'react-bootstrap';
import { RouteComponentProps, withRouter } from 'react-router';

import Product from '../types/product';
import Backend from '../actions/backend';

import './ProductsList.css';

type ProductsListProps = {
};

type ProductsListState = {
  products: Product[];
};

class ProductsList extends React.Component<RouteComponentProps<ProductsListProps>, ProductsListState> {
  state: ProductsListState = {
    products: [],
  };

  componentDidMount() {
    Backend.fetchAllProducts().then((response: any) => {
      if(response.status === 200) {
        this.setState({products: response.data.products})
      }
    })
  }

  onClickHandler(product: Product) {
    this.props.history.push(`/products/${product.uuid}`, product)
  }

  render() {
    return (
          <div>
            <CardDeck className='ProductsList-card-deck'>
            {
              this.state.products.map((product: Product, index: number) => {
              return(
                    <Card key = {index+1} className='ProductsList-card' onClick = { () => this.onClickHandler(product) }>
                      <Card.Header className='ProductsList-card-header'>{product.name}</Card.Header>
                      <Row>
                        <Col lg={3} md={3}>
                          <Card.Img className='ProductsList-image' src= {product.imageUrl} />
                        </Col>
                        <Col>
                          <Card.Body>
                            <Row>
                              <Col>
                                <span className={'ProductsList-bold'}>Price:</span>{product.price}
                              </Col>
                            </Row>
                            <Row>
                              <Col>
                                <span className={'ProductsList-bold'}>Description:</span>
                                {product.description}
                              </Col>
                            </Row>
                          </Card.Body>
                        </Col>
                      </Row>
                    </Card>
                );
              })
          }
          </CardDeck>
        </div>
    );
  }
}

export default withRouter(ProductsList);