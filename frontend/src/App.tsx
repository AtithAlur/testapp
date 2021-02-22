import React from 'react';
import {Route, Switch, Link} from "react-router-dom";

import Home from './components/Home';
import ProductDetails from './components/ProductDetails';
import Checkout from './components/Checkout';

import './App.css';

function App() {
  return (
    <div>
     <header className="App-header">
          <Link to='/' className='App-logo'>
            Curology Shop
          </Link>
      </header>
      <Switch>
        <Route exact path="/"><Home /></Route>
        <Route exact path="/products/:uuid"><ProductDetails /></Route>
        <Route exact path="/checkout"><Checkout /></Route>
      </Switch>
    </div>
  );
}

export default App;
