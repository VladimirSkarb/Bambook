#start api server
rvm install 2.5.3
rvm use 2.5.3@bambook_api --create
gem install bundler
bundle install
rails db:create db:migrate db:seed
rails s