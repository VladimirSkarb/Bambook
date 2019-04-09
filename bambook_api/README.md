#start api server<br/>
1. install docker и docker-compose
2. docker-compose run bambook_backend bundle exec rails db:create db:migrate db:seed
3. create .env in the root of bambook_api  folder(add params from .env.example)
4. http://localhost:3000/swagger   - swagger documentation
5. http://localhost:3000/admin     - active admin

userfull commands:
docker-compose up   - start containers in from current directory
docker attach<container_id>  - attach to existing container
docker-compose run bambook_backend bash  - attach to existing container bash
rails db:create db:migrate - use in bash to rin migrations