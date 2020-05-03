FROM ruby:2.7.0-alpine

ENV RACK_ENV=production
ENV RAILS_ENV=production
ENV APP_HOME=/app

RUN apk --no-cache add build-base postgresql-dev tzdata && \
    gem install bundler

RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

# Install gems
COPY Gemfile* $APP_HOME/

RUN bundle install --retry=10 --jobs=$(nproc)
RUN apk add yarn

# Copy the app code
COPY . $APP_HOME

# Expose port
EXPOSE 3000
EXPOSE 3035

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "80"]
