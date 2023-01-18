##### Prerequisites

The setups steps expect following tools installed on the system.

- Github
- Ruby 3.1.2
- Rails 7.0.4

##### 1. Clone the repository

```bash
git clone https://github.com/inFieldSupport/Roni_billing.git
```


##### 2. Install dependencies

```ruby
bundle install
```

##### 3. Configure database.yml file

username: your_postgres_username
password: your_postgres_password


##### 4. Create the database 

Run the following command to create the database.

```ruby
rails db:create
```

Migrate.

```ruby
rails db:migrate
```

Seed your database.

```ruby
rails db:seed
```

##### 5. Start the Rails server

You can start the rails server using the command given below.

```ruby
rails s
```

And now you can visit the site with the URL http://localhost:3000