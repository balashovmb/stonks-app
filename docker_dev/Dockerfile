FROM ruby:2.7.6

RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt update -q && apt install -y \
    build-essential \
    libpq-dev \
    postgresql-client \
    nodejs \
    nano \
    yarn \
    libvips > /dev/null

ENV APP_PATH /app
RUN mkdir -p $APP_PATH
WORKDIR $APP_PATH

ENV BUNDLE_PATH /bundle
ENV GEM_HOME /bundle
ENV PATH="/bundle/bin:${PATH}"

RUN printf '\
alias rc="bundle exec rails console" \n\
alias rtest="RAILS_ENV=test bundle exec rspec" \n\
alias be="bundle exec" \n\
alias rg="bundle exec rails generate" \n\
alias migrate_all="bundle exec rails db:migrate && RAILS_ENV=test bundle exec rails db:migrate" \n\
alias rollback_all="bundle exec rails db:rollback && RAILS_ENV=test bundle exec rails db:rollback" \n\
alias reset_db_all="bundle exec rails db:drop && bundle exec rails db:create && migrate_all" \n\
\n\
' >> ~/.bashrc

