[![Code Climate](https://codeclimate.com/github/gSchool/g2-social-network.png)](https://codeclimate.com/github/gSchool/g2-social-network)[![Build Status](https://travis-ci.org/gSchool/g2-social-network.svg?branch=master)](https://travis-ci.org/gSchool/g2-social-network)

# g2-social-network

##Background

The g2 Social Network application provides networking capabilities with between users.  The App is built on Rails 4.

##Important Links

+ [Tracker](https://www.pivotaltracker.com/n/projects/1079706 "Tracker")

+ [Staging](http://g2-social-network-staging.herokuapp.com/ "Staging")

##Setup


To get this application running locally, you should be able to simply clone this repository and run the following:

+ `cd g2-social_network`
+ `bundle install`
+ `rake db:create`
+ `rake db:migrate`
+ `rake db:seed`
+ `rake spec`
+ `rails s`

Please note that this application is using carrierwave with rmagick. Please install 'imagemagick' prior to using this app through whatever
 means you use (i.e. if you use homebrew: `brew install imagemagick`).
