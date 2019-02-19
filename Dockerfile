FROM ruby:1.9.3

# Install stuff
RUN apt-get update -qq && apt-get install -y build-essential

# Working folder.
RUN mkdir /app
WORKDIR /app
COPY . .

# Install Gems.  Use Bundler 1.17.3 as 2+ does not work with
# Ruby 1.9.3.  Also update the rubygems to prevent frozen string
# errors.  Rubygems 2.7.8 is the latest version to support Ruby 1.9.3.
RUN gem install rubygems-update -v 2.7.8
RUN update_rubygems
RUN gem install bundler -v 1.17.3
RUN bundle install