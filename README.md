# Curology Shop

## Setup Requirements

* Docker
* Docker Compose
* Make sure that no processes are running on ports: 8080, 3000, and 3001

## Tools and Technologies used

* Ruby on Rails - Backend
* React - Frontend
* DB - Postgres
* Nginx - Web server (proxy)

## Instructions to Run

* Run the below command

```bash
  docker-compose up --build
```

* The command will spin up four docker containers

  * **web** - Nginx container
  * **frontend** - NodeJs container for the React frontend App
  * **backend** - Ruby container for the backend application
  * **db** - Postgres container

* Once all the container and ready to serve, you can access the application at [http://localhost:8080](http://localhost:8080)
* Access the backend application with: [http://localhost:8080/api/magic](http://localhost:8080)

## Project Structure

* backend - Backend Ruby on Rails application
  
  * app - MVC source code
    * channels
    * controllers
      * api
        * magic_controller.rb - Controller for `/api/magic` endpoint
        * products_controller.rb - Controller for the frontend to fetch products
      * concerns - Common code for the controllers
    * jobs
    * mailers
    * models - All the ORM models
      * concerns - Common code for all the models
        * uuid_generator.rb - Generates an Uuid for the included models
      * address.rb - Object mapping for addresses table
      * application_record.rb - Rails provided common model class
      * credit_card.rb - credit_cards table
      * order_product.rb - order_products table
      * order.rb - orders table
      * price - prices table
      * product.rb - products table
      * stock.rb - stocks table
      * user.rb - users table
    * uploaders
      * product_image_uploader.rb - Module to store product images
    * views
  * config - Application/DB/Other Configurations
  * db - Migrations to create the require DB tables
  * lib
  * spec - Tests
  * storage
  * tmp
  * vendor
  * entrypoint.sh - This has commands to Install the required dependent libraries, create the DB tables, run tests, and initializes the basic data(Creates Magic Potion product).
  * Gemfile - Rails dependency management
* data - Volume mount for the db container
* docs - Documents
* frontend
* nginx
  * nginx.config - Nginx config file to setup proxy for the frontend and backend applications
* docker-compose.yml
* Dockerfile-backend - Docker file for the backend
* Dockerfile-frontend - Docker file for the frontend
