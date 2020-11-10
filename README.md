# README

* Ruby version
  - 2.6.6

* Rails version
  - 6.0.3

* System dependencies

  - [simple_form](https://github.com/heartcombo/simple_form)
  - [acts_as_votable](https://github.com/ryanto/acts_as_votable)

* Database creation

  ```bash
  rails db:create
  ```

* Database initialization

  ```bash
  rails db:migrate
  rails db:seed
  ```

* How to run the test suite

  ```bash
  RAILS_ENV=test rails db:migrate
  rspec spec/features/
  ```

#### Deployment instructions


##### Prerequisites

The setups steps expect following tools installed on the system.

- Github

- Ruby [2.6.6](https://github.com/ruby/setup-ruby)

- Rails [6.0.3](https://github.com/rails/rails)

##### 1. Check out the repository

```bash
git clone git@github.com:celsofilho82/vote-no-destino.git

```

##### 2. Set up Rails app

install the gems required by the application:

```bash
bundle
```

##### 2. Create and setup the database

Run the following commands to create and setup the database.

```ruby
rails db:create
rails db:migrate
rails db:seed
```

##### 3. Start the Rails server

You can start the rails server using the command given below.

```ruby
rails s
```

And now you can visit the site with the URL http://localhost:3000

#### Deploying on Heroku

Alternatively you can access this application on heroku through this address:

https://bluesoft-vote-no-destino.herokuapp.com/