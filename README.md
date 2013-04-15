SGfM project by PSE-Team 3
=============

Install (local)
-------

__Windows__
* Install Ruby (Version 1.8.7 or later)
* Install MongoDB (http://docs.mongodb.org/manual/tutorial/install-mongodb-on-windows/)
* Install the Devkit (https://github.com/oneclick/rubyinstaller/wiki/Development-Kit)
* Enter <code>gem install bundler</code> in console
* Navigate to project folder and enter <code>bundle install</code> in console

__Mac OS X__
* Install Ruby (Version 1.8.7 or later)
* Install MongoDB (http://docs.mongodb.org/manual/tutorial/install-mongodb-on-os-x/)
* Enter <code>sudo gem install bundler</code> in terminal
* Navigate to project folder and enter <code>sudo bundle install</code> in terminal

__Linux__
* Install Ruby (Version 1.8.7 or later)
* Install MongoDB (http://docs.mongodb.org/manual/tutorial/install-mongodb-on-linux/)
* Enter <code>sudo gem install bundler</code> in terminal
* Navigate to project folder and enter <code>sudo bundle install</code> in terminal


Run
---

__Windows__
* Enter <code>C:\mongodb\bin\mongod.exe</code> in console to start MongoDB
* Navigate to project folder in console
* Enter <code>rails s/code> in console to start server

__Mac OS X, Linux__
* Enter <code>mongod</code> in terminal to start MongoDB 
* Navigate to project folder in terminal
* Enter <code>rails s</code> in terminal to start server

Login
----

Go to <code>http://localhost:3000</code> in browser and use the following data to login:

__User__
* Username: <code>email@domain.ch</code>
* Password: <code>test1234</code>

__Admin__
* Username: <code>admin@domain.ch</code>
* Password: <code>test1234</code>

Test
----

__Windows__
* Enter <code>C:\mongodb\bin\mongod.exe</code> in console to start MongoDB
* Navigate to project folder in console
* Enter <code>bundle exec rspec spec</code> in console to run RSpec tests

__Mac OS X, Linux__
* Enter <code>mongod</code> in terminal to start MongoDB 
* Navigate to project folder in terminal
* Enter <code>bundle exec rspec spec</code> in terminal to run RSpec tests

Install (server)
----

Instructions on how to install everything on a server will follow.
