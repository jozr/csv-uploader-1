Renewable Funding: Code Challenge
=================================
Josie Wright Edition
====================

##Tools
Ruby 2.1.2<br />
ActiveRecord<br />
Rails 4.1.6<br />
PostgreSQL<br />
Sinatra<br />

##Setup

Make sure you've installed all the tools.

Install all the dependencies:

```console
$ bundle install
```

Set up the databases on your local machine:

```console
$ createdb deal_a_day
$ rake db:schema:load
```

Start the sinatra server within the root:

```console
$ ruby main.rb
```

Now, it should be available at `http://localhost:4567`.

RSpec tests can also be run in the terminal root:

```console
$ rspec
```

##Login

Logging in and out of application is straightforward. To login, click the `Login` link and submit your information into the form. To logout, click the `Logout` link. Registration and verification are not included. 

I simplified the login process to only forbid file uploads from unlogged users.

##License
MIT