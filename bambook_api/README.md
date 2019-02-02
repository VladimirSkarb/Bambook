#start api server<br/>
rvm install 2.5.3<br/>
rvm use 2.5.3@bambook_api --create<br/>
gem install bundler<br/>
bundle install<br/>
rails db:create db:migrate db:seed<br/>
rails s<br/>

rails db:drop
bundle install
create .env in root(add params from .env.example)
rails db:create db:migrate db:seed
rails s

http://localhost:3000/swagger   - swagger documentation


