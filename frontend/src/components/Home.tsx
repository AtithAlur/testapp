import React from "react";
import Container from 'react-bootstrap/Container'
import { Col, Row } from 'react-bootstrap';

import ProductsList from './ProductsList';

type HomeProps = {};
type HomeState = {};

class Home extends React.Component<HomeProps, HomeState> {
  state: HomeState = {};

  render() {
    return (
      <Container>
          <Row>
            <Col>
               <ProductsList />
            </Col>
          </Row>
      </Container>
    );
  }
}

export default Home;