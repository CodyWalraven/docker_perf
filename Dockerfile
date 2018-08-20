FROM selenium/standalone-chrome

RUN sudo apt-get update
RUN sudo apt-get -y install ruby-all-dev \
    && sudo apt-get -y install build-essential software-properties-common 

COPY . /app
WORKDIR /app

RUN sudo gem install bundler
RUN sudo bundle install
RUN sudo bundle clean --force

CMD sudo ruby main.rb



