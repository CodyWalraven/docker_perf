FROM browserless/chrome
#FROM selenium/standalone-chrome

RUN apt-get update 
RUN apt-get -y install apt-utils 
RUN apt-get -y install ruby
RUN apt-get -y install ruby-all-dev
RUN apt-get install -y unzip xvfb libxi6 libgconf-2-4
RUN apt-get install -y default-jdk 


COPY . /app
WORKDIR /app

RUN gem install bundler
RUN bundle install


RUN wget https://chromedriver.storage.googleapis.com/2.35/chromedriver_linux64.zip
RUN unzip chromedriver_linux64.zip
RUN mv chromedriver /usr/bin/chromedriver
RUN chown root:root /usr/bin/chromedriver
RUN chmod +x /usr/bin/chromedriver
RUN wget https://selenium-release.storage.googleapis.com/3.9/selenium-server-standalone-3.9.1.jar
RUN wget http://www.java2s.com/Code/JarDownload/testng/testng-6.0.1.jar.zip
RUN unzip testng-6.0.1.jar.zip

CMD chromedriver --url-base=/wd/hub

#This starts chrome with a gui (prob wont work on docker)
# RUN xvfb-run java -Dwebdriver.chrome.driver=/usr/bin/chromedriver -jar selenium-server-standalone.jar





