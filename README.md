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

* Once all the container are ready to serve, you can access the application at [http://localhost:8080](http://localhost:8080)
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

## Database Design

![DB Design](./docs/DB.png)

### Common columns:

* uuid (indexed) - A unique hash for real world entities to refer by other applications
* id - Auto incrementing integer Id for internal mapping
* created_at - Tracks when a record is created
* updated_at - Tracks when a record is last updated

### Tables

* users
  * first_name - String of length 50
  * last_name - String of length 50
  * email_id (indexed) - Identifies a user uniquely by email_id
  * phone - String of length 10

* orders
  * user_id - Foreign key to users table
  * credit_card_id - Foreign key to credit_cards table
  * address_id - Foreign key to addresses table
  * status - Enum values includes: 'pending', 'fulfilled', 'delivered', 'canceled'
  * total - Order total = All order_products qunatity * products.prices.price

* credit_cards - Creates a new credit if doesn't exists during the order request.
  * user_id - Foreign key to users table
  * card_number (indexed)- String of length 20
  * expiry - Stores expiry in the format MM/YYYY

* addresses - Creates a new address if a doesn't exist by address_line1 for the user
  * address_line1 (indexed) - String of length 50
  * address_line2 - String of length 50
  * city - String of length 20
  * state - String of length 2 that stores abbrevations
  * zip - String of length 10(Support for county codes)

* products - For now, it will be just **Magic Potion**
  * name - String of length 50
  * order_limit - cap on order limits
  * description - text
  * image - Image

* prices - Supports multiple price entries per produc, but uniquely referenced in order_products table
  * product_id - Foreign key to products table
  * price - Decimal value (10, 2)

* stocks - Future support
  * product_id - Foreign key to products table
  * quantity - Available quantity

* order_products - Mapping of order and products. It supports multiple orders(Max 3) per user
  * order_id (indexed) - Foriegn key to orders table
  * product_id (indexed)- Foreign key to products table
  * price_id - Foreign key to prices table
  * quantity - Ordered qunatity
  * sub_total - Order sub total = quantity * price




