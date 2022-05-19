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

RUN gem install bundler
COPY Gemfile Gemfile.lock ./
RUN bundle check || bundle install

COPY package.json yarn.lock ./
RUN yarn install --check-files

COPY . ./

# ENTRYPOINT ["./docker-dev/docker-entrypoint.sh"]
