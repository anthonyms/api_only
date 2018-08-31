# README

* Ruby Version: ruby 2.5.0
* Rails Version: Rails 5.1.6
* Server: Passenger
* Database: Postgres
* Deployed to IP: 142.93.13.239

## Endpoints
   POST `/api/v1/users/register :email, :phone, :password`
   
   POST `/api/v1/users/login :email, :password`
   
   POST `/api/v1/account/top_up :account, :amount`
   
   POST `/api/v1/transfer/transfer :sender, :recipient, :amount`
   
   POST `/api/v1/account/report :account, :start_date, :end_date`
   
   
   Screenshot from 2018-08-31 14-13-17.png contains the database schema
   api-only.postman_collection.json is a Postman collection of the endpoints.
   
   
Recommended flow.
1. Call the register endpoint with a username, phone and password.
2. Call the login endpoint with the credentials provided the in step 1. You will get back a authorization-token. 

   All subsequent endpoints will need the authentication-token in the Authorization header.

3. Call the top-up endpoint to top up the msisdn with some money.
4. Transfer funds to another existing user via the transfers endpoint
5. The report endpoint will display all transactions for a given account. 
6. Have fun
   
   

