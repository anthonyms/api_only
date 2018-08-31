# README

* Ruby Version: ruby 2.5.0
* Rails Version: Rails 5.1.6
* Server: Passenger
* Database: Postgres
* Deployed to IP: 142.93.13.239

## Endpoints
   POST `/api/v1/users/register :email, :phone, :password`
   
   POST `/api/v1/users/login :email, :password`
   
   POST `/api/v1/transfer/transfer :sender, :recipient, :amount`
   
   POST `/api/v1/account/top_up :account, :amount`
   
   POST `/api/v1/account/report :account, :start_date, :end_date`
   
   
   

