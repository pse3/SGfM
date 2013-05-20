# Welcome 

This is a Ruby on Rails application based on a MongoDB database. 

Its purpose is to provide a tool to collect and display data about the supply structures 
between actors (i.e. doctors, hospitals) in the regional medical sector. 

The customer of this  application was ["Schweizerische Gesellschaft für Medizincontrolling" (SGfM)](http://www.medizincontroller.ch/index.html) 
and it was created as part of a lecture called ["Praktikum Software Engineering"](http://www.ltg.unibe.ch/lectures/FS13/PSE)
at the University of Bern. 

# Authors

Please see AUTHORS.md file for further (contact) information 
about the authors of this application.

# Directories

   * All the source code of the application is located in the app/ directory. 
   * All the source code of the tests is located in the spec/ directory. 

# Install

For installation on a server, please see INSTALL.md file for further instructions.

If you want to install this application locally, make sure you have Ruby (version 1.9.3), 
MongoDB (version 3.2 or later) and Bundler installed on your machine. Download the source
code of this application and navigate to the top directory. Then open a terminal/console 
and run 

       bundle install 

This should install all the required gems. Now start MongoDB with

       mongod
       
and finally the application with

       rails s
       
# Testing

To run the provided tests, make sure you have Ruby (version 1.9.3), 
MongoDB (version 3.2 or later) and Bundler installed on your machine. Download the source
code of this application and navigate to the top directory. Then open a terminal/console 
and run 

       bundle install 

This should install all the required gems. Now start MongoDB with

       mongod
       
and finally run the spec tests with

       bundle exec rspec spec'
