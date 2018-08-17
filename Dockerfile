
FROM selenium/standalone-chrome

RUN sudo apt-get update 

RUN sudo apt-get -y install ruby
RUN sudo apt-get -y install ruby-all-dev
RUN sudo apt-get install build-essential software-properties-common -y
RUN sudo add-apt-repository ppa:ubuntu-toolchain-r/test -y
RUN sudo apt-get -y install gcc
RUN sudo apt-get -y install libffi6
RUN sudo apt-get -y install libffi-dev


COPY . /app
WORKDIR /app


RUN sudo gem install bundler
RUN sudo bundle install


CMD sudo ruby main.rb


#This starts chrome with a gui (prob wont work on docker)
# RUN xvfb-run java -Dwebdriver.chrome.driver=/usr/bin/chromedriver -jar selenium-server-standalone.jar





