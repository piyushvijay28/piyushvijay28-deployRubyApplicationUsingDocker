# Base Ruby image
FROM ruby:3.1.2

# Set working directory inside container
WORKDIR /app

# Install dependencies
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  yarn

# Install bundler
RUN gem install bundler -v 2.3.6

# Copy Gemfiles and install gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy the rest of the app
COPY . .

# Precompile assets (optional for dev)
# RUN bundle exec rake assets:precompile

# Start the Rails server (overridden by docker-compose)
CMD ["rails", "server", "-b", "0.0.0.0"]

