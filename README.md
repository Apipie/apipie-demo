# Apipie Usage Example Application

This is a sample Rails application demonstrating the features of the
[Apipie](http://github.com/Pajk/apipie-rails) gem.

For more information see the documentation for the Apipie gem.

### Getting started

The idea behind this sample app called "TwitterScheduler" is a service
that allows you to schedule tweets for users in future. It contains
two resources with CRUD operations: users and tweets (that are nested
inside the users).

To run this demo, you need to run Ruby 1.9.2 or higher (although the
Apipie gem is compatible with 1.8.7).

To get the app up and running run these commands:

    bundle install
    rake db:setup
    rails server

To test that it works we can use `curl` to see it working:

    curl -H "Content-Type: application/json" -X POST\
         -d '{"user":{"name":"admin"}}'\
          http://localhost:3000/api/v1/users

    curl -H "Content-Type: application/json" -X POST\
         -d '{"tweet":{"text":"Hurray, I've survived",
                       "scheduled_at":"2012-12-22T01:00"}}'\
          http://localhost:3000/api/v1/users/1/tweets

### Api Doc In 1 Minute

Setting up the Apipie to be used in our app is simple. We
add the dependency into our `Gemfile` and run `bundle install` again:

```ruby
gem 'apipie-rails'
```

Then set up the basic configuration:

    rails g apipie:install --api_path ""

Although we have no documentation yet, `routes.rb` and our tests
already contain very interesting information. All we need is to put it
into one place. And Apipie provides a way how to do it:

    APIPIE_RECORD=params rake test:functionals
    APIPIE_RECORD=examples rake test:functionals

CONGRATULATION!!! You've just created the first cut documentation of
your API.

When we open the `TweetsController` we can see, that out of a sudden
there is a description of every action. And more then that: the tool
also tried to recognize the type of params if possible (such as the
`sent` param is `:bool`).

To see the output, just open `http://localhost:3000/apipie`.

You might notice that besides the params descriptions there are also
examples available in the documentation, although they are not in the
source code. Apipie uses separate file `doc/apipie_examples.yml`.
That makes the code more readable (the examples can really be
disturbing) and also makes it easier to regenerate the examples again
and again.

### Time To Share

You might decide to make your documentation available without need to
run the service itself. All you need is to run:

     rake apipie:static

You can find various versions of the static HTML in `doc/apidoc*`
files (structured, one-page, plain html).

### Versioning

You can specify the resource and/or an action to one or more versions.
After that, you can see the documentation for all the versions. You
can also generate static files for a given version by running (in this
example version 2):

    rake apipie:static[2]

### DRY

The params can be grouped together and reused for more actions:

```ruby
# v1/users_controller.rb
def_param_group :address do
  param :street, String, "Street name"
  param :number, Integer
  param :zip, String
end

def_param_group :user do
  param :user, Hash, :required => true, :action_aware => true do
    param :name, String, "Name of the user"
    param_group :address
  end
end

api :POST, "/users", "Create an user"
param_group :user
def create
  # ...
end

api :PUT, "/users/:id", "Update an user"
param_group :user
def update
  # ...
end

# v2/users_controller.rb
api :POST, "/users", "Create an user"
param_group :user, V1::UsersController
def create
  # ...
end
```

### Conclusion

We've just gone through the basic scenarios that are covered by the
Apipie gem. I hope you've liked it. For more information see the
documentation for the gem. There are other features you might be
interested in, such as:

  * API for your doc
  * different markup languages support
  * cache in production
  * and others

The tool will be just as good as the users decide it to be. If you
find a bug or you have a suggestion for improvement, please file an
issue in the Github tracker.
