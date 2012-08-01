# Rails administration dashboard example

A roll-your-own alternative to admin gems for Rails applications, using RSpec request specs for some basic BDD goodness. See http://everydayrails.com/2012/07/31/rails-admin-panel-from-scratch.html for details or to post questions/comments.

This source and the accompanying series of tutorials are currently a work in progress.

## To get started

Written with Ruby 1.9.3.

Clone the repository, then

    cd admin_demo
    bundle
    rake db:create
    rake db:migrate
    rake db:setup
    rake db:test:prepare
    guard (or however you want to run the specs)