FROM ruby:3.0.2 


ENV BUNDLER_VERSION=2.2.28
ENV NODE_VERSION_MAJOR=14

WORKDIR /c2s-project

RUN curl -fsSL https://deb.nodesource.com/setup_${NODE_VERSION_MAJOR}.x | bash 
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - 
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list 
RUN apt-get update && apt-get install -y nodejs yarn postgresql-client

COPY Gemfile /c2s-project/Gemfile
COPY Gemfile.lock /c2s-project/Gemfile.lock
COPY package.json /c2s-project/package.json
COPY yarn.lock /c2s-project/yarn.lock

RUN gem install bundler -v $BUNDLER_VERSION && \
  bundle check || bundle install && \
  yarn install && \
  yarn cache clean 

COPY . /c2s-project

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT [ "entrypoint.sh" ]
EXPOSE 3000

CMD [ "rails", "server", "-b", "0.0.0.0" ]