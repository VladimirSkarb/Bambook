#start api server<br/>
1. install docker и docker-compose
2. docker-compose run bambook_backend bundle exec rails db:migrate db:seed
3. create .env in the root of bambook_api  folder(add params from .env.example)
4. http://localhost:3000/swagger   - swagger documentation
5. http://localhost:3000/admin     - active admin


