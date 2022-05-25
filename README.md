# StonksAPP

### StonksAPP is my pet-project. A trading terminal simulator for the American stock market.

#### Technologies and principles used in this project:

* TDD/BDD (Using Rspec, Capybara)
* Getting data using the API(Source is tradier.com API)
* Service objects
* Background jobs (Using ActiveJob)
* ActionCable, CableReady

#### App is deployed [here](http://stonks.balashov.net.ru/)

## Development with docker-compose (optional)

### Prerequisites

1. [Install docker](https://docs.docker.com/get-docker/)
2. Don't forget [Post-install section (for linux)](https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user)
2. Add an alias for `docker-compose` for ease use

```bash
echo "alias dcdev='docker-compose -f docker-compose-dev.yml'" >> ~/.bashrc

# For Oh My Zsh
echo "alias dcdev='docker-compose -f docker-compose-dev.yml'" >> ~/.zshrc
```

3. Reload your rc file

```bash
. ~/.bashrc

# For Oh My Zsh
. ~/.zshrc
```

4. For Redis, add `vm.overcommit_memory = 1` to your `/etc/sysctl.conf`

### First run

1. Copy and edit `.env` file 

```bash
cp docker_dev/.env_docker.example docker_dev/.env_docker
```

2. Build an image

```bash
dcdev build
```

3. Run app

```bash
dcdev up
```

4. Create a Database and run migrations

```bash
dcdev run web bundle exec rails db:setup
# or
dcdev run web bundle exec rails db:create
dcdev run web bundle exec rails db:schema:load
dcdev run web bundle exec rails db:seed
```

### Regular dev workflow

1. Run `dcdev up` and you are good to go.
2. To run any Rails related command, just shell `dcdev run web bash` and execute anything you want inside container.
3. You can use or add any aliases you want, see `docker_dev/Dockerfile`. Don't forget to rebuild an image: Run `dcdev down` to stop everything and `dcdev build` to rebuild
4. You might have an issues on Linux OS with permissions on files that created by Docker. Just run chown `sudo chown -R YOUR_USER:YOUR_GROUP .`

### Debugging

1. Place `binding.pry` or any other debugger in a place you need
2. Run `docker attach CONTAINER_NAME_web_1` to access console (Note that there might be some issues, see https://github.com/docker/compose/issues/423#issuecomment-141995398)