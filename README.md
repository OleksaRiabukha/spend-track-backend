# README

Ruby on Rails API repository for the finance tracking app.

- ruby: 3.0.1
- rails: 6.1.3.2
- database: postgresql
- mode: API
- test suite: RSpec

## Test
- the app is deployed on [heroku](https://spend-and-track.herokuapp.com/) in API mode
- to test it, user should register an account via [signup_path](https://spend-and-track.herokuapp.com/api/users) with valid credentials, example of the POST request body: 

`{ "user": { "first_name": "random", "last_name": "user", "email": "random@mail.com", "password": "password"}}`

- after that you'll receive a JWT token, which should be added to headers for the each request. Example of header: 

`Authorization: your_token`
 
- the frontend part is deployed on [heroku](https://spend-and-track-fe.herokuapp.com/) 
- the frontend [repository](https://github.com/OleksaRiabukha/spend-track-frontend)

## Run localy 

- clone repository locally 
- `bundle install`
- ask the owner about credentials keys
- create postgres databases and roles 
- run `rails -s`
