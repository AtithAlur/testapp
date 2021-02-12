# Magic Potion Launch Site

Curology has just created a new product that will revolutionize the skincare industry and we're ready to unveil it to the world. This product is so different and magical that it requires its very own distinct workflow separate from the other Curology products. You are tasked with developing this new site.

We understand you have other priorities. You may work at your own tempo to complete this assignment. On average this exercise should take approximately 4-6 hrs to complete. Please inform us should you require more than a week's time to submit or have opted to not complete the assignment. Your feedback is extremely important to us and will help us refine our process.

**Project Submission**
**Good**: Provide a readme file with instructions on how to run your site, and commit it along with your code to this repo.

**Best**: Signup and deploy your site to a platform such as Heroku. Provide a link to your  site and git repo containing a readme that documents tech stack used and instructions on how to run your site.

Part of your evaluation will be based on the clarity and understandability of your documentation.

---

**High Level Requirements**:

Although we have a soft spot for React and Laravel, you may in the language of your choice, create a single page that allows a user to purchase the magic potion.

---

**Front end specifications**:

1. Capture the following user information in a form:
    - First and Last Name
    - Email
    - Address (street1, street2, city, state, zip)
    - Phone Number
    - Payment information: Normally, we would not be storing payment information and would prefer to integrate a service such as Stripe or Square. For the purpose of this exercise, assume we have a magical merchant system to process our magic potion orders. In the form, provide text fields to capture the user's credit card number and expiration date.
    
      ![Privilege Gold Card](docs/privilege-gold-card.png?raw=true "Privilige Gold Card")

    - Quantity field that allows user to specify how many potions they'd like to purchase. (Max 3)
    - Calculated field that displays the product of the quantity multiplied by the base unit price of 49.99 per potion.

2. A button that submits the form and validates all fields are completed properly and that none are empty. All fields should be evaluated as strings/text except for the quantity field, which should be a number/integer.

    On success:

    - All fields should clear to it's original state

    On failure:

    - Fields should not clear
    - Display an indicator showing which field caused the failure

    We will also be verifying that we cannot do such things as:

    - order more than 3 potions
    - enter a non-numeric value in the quantity field
    - submit multiple orders under the same name etc.
3. A notification to the user after the form was submitted to the API
    - e.g. "Your order has been placed!", "Error: Magic potion order may not exceed maximum quantity", "A user with the same name at this address already exists"
    - You have the option to choose how and where data validation is implemented.
4. You have free range to be creative in how you implement and design your form.
    - e.g. Name fields may be represented in your UI as 1 or more fields. (We may find it strange if you have more than 3)
    - e.g. For quantity, you may decide to use a drop down list containing values 1-3 or a free text field and validate the input on change, on keyup, on keydown or on blur etc...
    - This is an example of a basic form. Feel free to move and organize fields in a way that is more interesting to you. E.g. collapsing and expanding sections, size of fields, color and fonts.

        ![Example Form](docs/form.png?raw=true "Example Magic Potion Form")

**Backend specifications**:

In the language of your choice, create an API that accepts the following endpoints

- POST /api/magic
    - Receives the following request

        ```bash
        {
        	"firstName": "string",
        	"lastName": "string",
        	"email": "string",
        	"address": {
        		"street1": "string",
        		"street2": "string",
        		"city": "string",
        		"state": "string",
        		"zip": "string"
        	},
        	"phone": "string",
        	"quantity": number,
        	"total": "string",
        	"payment": {
        		"ccNum": "string",
        		"exp": "string",
        	},
        }
        ```

    - before adding a new order to the DB, verify that the client is not submitting an order that will exceed the maximum of 3 magic potions per customer for a given month.
    - returns the following status and unique id

        ```bash
        201 CREATED

        {
        	"id": uid
        }
        ```

Although the client facing UI at this time does not require the ability to retrieve, update or delete order info, these endpoints should exist for a future system such as an admin UI to consume. These endpoints will be tested to be functional

- GET /api/magic/\<uid\>

    success response

    ```bash
    {
    	"firstName": "string",
    	"lastName": "string",
    	"email": "string",
    	"address": {
    		"street1": "string",
    		"street2": "string",
    		"city": "string",
    		"state": "string",
    		"zip": "string",
    	},
    	"phone": "string",
    	"payment": {
    		"ccNum": "string",
    		"exp": "string",
    	},
    	"quantity": number,
    	"total": "string",
    	"orderDate": date,
    	"fulfilled": bool,
    }
    ```

    failure response

    ```bash
    404 "resource not found"
    ```

- PATCH /api/magic/\<uid\>

    set the fulfilled column value to reflect the object's value. For simplicity in this exercise, we do not need to validate existing fulfilled state. We only need to know that an update associated to a unique id is functional and updating to the expected result and fail if attempting to update a uid resource that does not exist.

    ```bash
    {
    	"id": uid,
    	"fulfilled": bool
    }
    ```

    success response

    ```bash
    200 || 204 "resource updated successfully"
    ```

    failure response

    ```bash
    404 "resource not found"
    ```

- DELETE /api/magic/\<uid\>

    success response

    ```bash
    200 || 204 "resource deleted successfully"
    ```

    failure response

    ```bash
    404 "resource not found"
    ```

You may use any kind of storage to persist the data - SQL, NoSQL, text file or even local memory.

Although a DB is not required, please document and describe the data schema for your site in the readme file. See ReadMe section below for details on what should be included in your readme file.

**ReadMe**:

On top of the description on how to run your site, please provide answers to the following questions in your readme.

- Describe your data schema and how it relates to the purchasing of magic potions.
- Describe how this could scale over time.
- Describe your front end architecture and why you chose to create it as you did. Include details about form validation, error handling etc.
- Describe the API architecture
- With more time or in a different environment, what would you do differently?
- What would you do to improve or scale the application?

**BONUS**:

Create unit test(s) for each route

Add custom CSS style to your front end.
