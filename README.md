# README

[Github Link](https://github.com/alcren/pingsapi)

The app is deployed on heroku. You may use this base url https://pingsapi.herokuapp.com

Note: Due to dyno sleeping in heroku, app may respond longer on your first request.

If you wish to run locally do the following:

* Install [Ruby](https://www.ruby-lang.org/en/documentation/installation/)
Version used `ruby 2.5.0p0`

* After installing ruby install Rails by running `gem install rails`
Version used `Rails 5.1.5`

* Install [PostgreSQL](https://www.postgresql.org/docs/9.3/static/tutorial-install.html)

* Create a database with the following details
  * Database name: pingsdb
  * Username: ren
  * Password: ren


* In the directory pingsapi run `bundle install`

* Migrate database by running `rake db:migrate`

* Start the server by running `rails s`

* The api will be running at http://0.0.0.0:3000

Note: pings.rb is in /todo
