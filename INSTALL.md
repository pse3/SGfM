# Overview

The installation consists of setting up the following components:

1. Packages / Dependencies
2. Ruby
3. Database
4. Software


# 1. Packages / Dependencies

`sudo` is not installed on Debian by default. Make sure your system is
up-to-date and install it.

    # run as root
    apt-get update
    apt-get upgrade
    apt-get install sudo

**Note:**
Vim is an editor that is used here whenever there are files that need to be
edited by hand. But, you can use any editor you like instead.

    # Install vim
    sudo apt-get install -y vim

Install the required packages:

    sudo apt-get install -y git-core redis-server rake libxml2-dev libxslt1-dev openssl


# 2. Ruby

**Important Note:**
Ruby version must be 1.9.3 or higher

Download and compile it according to [`Official Ruby Website`](http://ruby-lang.org).

    

Install the Bundler Gem:

    sudo gem install bundler




# 3. Database
If you use `Ubuntu`, you can install Ruby with:

    sudo apt-get install mongodb

To setup the MongoDB database and dependencies please see [`Official MongoDB Website`](http://www.mongodb.org/).


# 4. Software


## Clone the Source

    # Clone repository
    git clone https://github.com/pse3/SGfM.git

    # Go into dir
    cd ./SGfM

    # Checkout to stable release
    git checkout stable


## Configure it

    vim ./SGfM/config/environments/production.rb

    # enter your server deteils in the section
      config.action_mailer.default_url_options = { 
      :host => 'YOUR_DOMAIN',  # Enter the domain the software is running on
      :locale =>I18n.locale 
      }

    # SMTP settings
    config.action_mailer.smtp_settings = {
      :enable_starttls_auto => true,
      :address => "smtp.gmail.com", # SMTP Server
      :port => 587, # SMTP Port
      :domain => "gmail.com", # SMTP Domain
      :authentication => :login,
      :user_name => "xx@gmail.com", # SMTP Username
      :password => "pw", # SMTP Password
    }



## Install Gems

    cd ./SGfM

    # update core gems
    sudo gem update --system

    # install dependent gems
    sudo bundle install 
   


## Initialise Database and Activate Advanced Features

    rake db:seed RAILS_ENV=production


## Start Your Instance

    rails s -d -e production 
    
    # use -p XXXX to set a port



Visit YOUR_SERVER for your first login.
The setup has created an admin account for you. You can use it to log in:

    admin@domain.ch
    test1234
    
The setup has created a demo user account for you. You can use it to log in:

    email@domain.ch
    test1234

**Important Note:**
Please go over to your profile page and immediately change the password (*especially the admin password!!*), so
nobody can access your site using this login information later on.

If you occur any problems during installation, please let us know by contacting us via github issue tracker

**Enjoy!**
