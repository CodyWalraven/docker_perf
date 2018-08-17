require "selenium-webdriver"

class Login
    attr_accessor :email, :password
 
    def initialize      
        options = Selenium::WebDriver::Chrome::Options.new
        options.add_argument('--headless')
        $driver = Selenium::WebDriver.for :chrome, options: options
        $driver.navigate.to "https://login.assetpanda.com/asset_items"
        @login_element = $driver.find_element(name: 'user[email]')
        @password_element = $driver.find_element(name: 'user[password]')
        @submit_element = $driver.find_element(name: "commit")               
    end

    #If no credentials entered this loads them from email.txt and passwords.txt
    def login_system (email,password,load_from_file)
        if load_from_file == true
            @password_from_file = File.readlines 'password.txt'
            @password_from_file.each_with_index{|line, i| puts "#{i+1}: #{line}"}
            @email_from_file = File.readlines 'email.txt'
            @email_from_file.each_with_index{|line,i| puts "#{i+1}: #{line}"}
            @email_for_password_reset = @email_from_file
            @login_element.send_keys @email_from_file
            @password_element.send_keys @password_from_file
            @submit_element.submit
            

        elsif load_from_file == false    
            @email = email
            @password = password
            @email_for_password_reset = password
            @password_element.send_keys @password
            @login_element.send_keys @email
            @submit_element.submit
        
        else
            raise "Uh oh you need to only put true or false in load_from_file"
        end
    end


# This is broken for now because I have to solve a recaptcha to submit password reset
    def reset_password
        $driver.navigate.to "https://login.assetpanda.com/users/password/new"
        @reset_password_text_box = $driver.find_element(name: 'user[email]')
        @reset_password_text_box.send_keys @email_for_password_reset
        @not_a_robot_button = $driver.find_element(name: 'recaptcha-checkbox-checkmark')
        @not_a_robot_button.submit
       
    end


end
