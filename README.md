<a name="readme-top"></a>

<!-- PROJECT LOGO -->
<br />
<div align="center">

  <h2 align="center"><strong>Tea Box API</strong></h2>

  <p align="center">
    Module 4 Take Home<br>
    Turing School of Software and Design<br>
    Cohort: 2211 Back End
    <br />
  </p>
</div>


### Built With

![Ruby](https://img.shields.io/badge/Ruby-CC342D?style=for-the-badge&logo=ruby&logoColor=white) 
![Ruby on Rails](https://img.shields.io/badge/Ruby_on_Rails-CC0000?style=for-the-badge&logo=ruby-on-rails&logoColor=white) 
<img src="https://mainstreetcomputing.com/assets/technologies/rspec-a6d57cd7ff8186c261a23f03d186b716.png" alt="Rspec Badge" height="27" width="60">
![Postgresql](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)
![GitHub](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white)
![VSCode](https://img.shields.io/badge/VSCode-0078D4?style=for-the-badge&logo=visual%20studio%20code&logoColor=white)

Gems Used: Pry, simplecov, shoulda-matchers, jsonapi-serializer


<!-- ABOUT THE PROJECT -->
## About The Project
<hr>

[Take-Home](https://mod4.turing.edu/projects/take_home/) is the final project for the Turing School's module 4 program. Throughout module 4, we have started to dive in to preparing for the interview process. This project allows students to plan for and exectue a take home exam.
<br> 
Tea Box is an API that allows users to make tea subscriptions for customers. 

## Learning Goals
<hr>
<ul>
  <li>Complete a take-home style exam in 8 hours</li> 
  <li>Learn how to manage time for a project of this scope</li>
  <li>Be able to explain your process and decisions</li>
</ul>


<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- GETTING STARTED -->
## Getting Started
<p>* Before running these steps, make sure you have the correct versions of ruby and rails*</p>

1. Fork and clone this repo
`git clone git@github.com:KaraJoHo/tea_box.git`
2. Run bundle install in your terminal
`bundle install`
3. Set up the database by running:
`rails db:{drop,create,migrate,seed}`
4. Run rails s to start the server
`rails s`
5. Open postman to test the endpoints 
If you don't have postman, go to https://www.postman.com to install it and read about use. You can access one endpoint from your browser after running the server by searching `http://localhost:3000//api/v1/customers/1/subscriptions` <br>
However, for the `post` and `patch` requests, you will need to use postman to test those endpoints.
  

### Configuration
* Ruby version 3.1.1
* Rails version 7.0.4

## Testing 
<p>To run tests, type this in your terminal: </p>

 `bundle exec rspec` 
<p>All tests should be passing</p>
<hr>

## Schema 
<img src=".github/schema.png">
<hr>



<!-- USAGE EXAMPLES -->
## Endpoint Requests and Responses

#### Here are some examples of requests and responses ran in Postman.
<br>

<details>
  <summary><strong>Endpoints</strong></summary>
   <br>
   <hr>
  
   Request: `GET /api/v1/customers/1/subscriptions`
   <br>
   Response: 

   <img src=".github/customers_subscriptions.png">
   <br>
   <hr>

   Request: `POST /api/v1/customers/1/subscriptions`
   Request Body: 
   <img src=".github/create_request_body.png">
   <br>
   Response:

   <img src=".github/create_subscription.png">
   <br>
   <hr>

   Request: `PATCH /api/v1/customers/1/subscriptions/2`
   Request Body: 
   <img src=".github/update_request_body.png">
   <br>
   Response:

   <img src=".github/update_status.png">
   <br>
</details><br>
<hr>



<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- CONTACT -->
## Contact

Reach out anytime on [LinkedIn](https://www.linkedin.com/in/81012911-91208/)

<p align="right">(<a href="#readme-top">back to top</a>)</p>