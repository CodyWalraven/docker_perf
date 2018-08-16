FROM ubuntu

RUN apt-get update 
RUN apt-get -y install apt-utils 
RUN apt-get -y install ruby
RUN apt-get -y install ruby-all-dev
RUN apt-get install -y unzip xvfb libxi6 libgconf-2-4 

COPY . /app
WORKDIR /app

RUN gem install bundler
RUN bundle install

RUN # Versions
RUN CHROME_DRIVER_VERSION=`curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE`
RUN SELENIUM_STANDALONE_VERSION=3.4.0
RUN SELENIUM_SUBDIR=$(echo "$SELENIUM_STANDALONE_VERSION" | cut -d"." -f-2)

RUN # Remove existing downloads and binaries so we can start from scratch.
RUN apt-get remove google-chrome-stable
RUN rm ~/selenium-server-standalone-*.jar
RUN rm ~/chromedriver_linux64.zip
RUN rm /usr/local/bin/chromedriver
RUN rm /usr/local/bin/selenium-server-standalone.jar

RUN # Install dependencies.
RUN apt-get update
RUN apt-get install -y unzip openjdk-8-jre-headless xvfb libxi6 libgconf-2-4

RUN # Install Chrome.
RUN curl -sS -o - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add
RUN echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list
RUN apt-get -y update
RUN apt-get -y install google-chrome-stable

RUN # Install ChromeDriver.
RUN wget -N http://chromedriver.storage.googleapis.com/$CHROME_DRIVER_VERSION/chromedriver_linux64.zip -P ~/
RUN unzip ~/chromedriver_linux64.zip -d ~/
RUN rm ~/chromedriver_linux64.zip
RUN mv -f ~/chromedriver /usr/local/bin/chromedriver
RUN chown root:root /usr/local/bin/chromedriver
RUN chmod 0755 /usr/local/bin/chromedriver

RUN # Install Selenium.
RUN wget -N http://selenium-release.storage.googleapis.com/$SELENIUM_SUBDIR/selenium-server-standalone-$SELENIUM_STANDALONE_VERSION.jar -P ~/
RUN mv -f ~/selenium-server-standalone-$SELENIUM_STANDALONE_VERSION.jar /usr/local/bin/selenium-server-standalone.jar
RUN chown root:root /usr/local/bin/selenium-server-standalone.jar
RUN chmod 0755 /usr/local/bin/selenium-server-standalone.jar