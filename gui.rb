require_relative 'asset.rb'
require_relative 'login.rb'
require 'fox16'
include Fox

#initialize the chrome view, gui, and controllers for a few things
asset_controller = Asset.new
application = FXApp.new("FXRuby", "FoxTest")

#Load the image and set to display as logo (it's broke commenting out for now)
=begin
def getIcon(filename)
    begin
      filename = File.join("icons", filename)
      icon = nil
      File.open(filename, "rb") do |f|
        icon = FXPNGIcon.new(getApp(), f.read)
      end
      icon
    rescue
      raise RuntimeError, "Couldn't load icon: #{filename}"
    end
end
=end

   

        #create the window view
    main = FXMainWindow.new(application, "Asset Panda automated testing suite", nil, nil, DECOR_ALL,
        0, 0, 500, 300)


# Account Email Button===================================================
frame3 = FXHorizontalFrame.new(main,
    LAYOUT_LEFT | LAYOUT_SIDE_TOP| PACK_UNIFORM_WIDTH|FRAME_GROOVE)
account_val= FXDataTarget.new("Account Name")
textfield1 = FXTextField.new(frame3, 16, account_val, FXDataTarget::ID_VALUE,TEXTFIELD_NORMAL|LAYOUT_FILL_X|LAYOUT_FILL_COLUMN)

account_val.connect(SEL_COMMAND) do
    $account_email = account_val
end
#=========================================================================

#Password Field===========================================================
frame4 = FXHorizontalFrame.new(main,
    LAYOUT_LEFT | LAYOUT_SIDE_TOP| PACK_UNIFORM_WIDTH|FRAME_GROOVE)
password_val= FXDataTarget.new("Password")
textfield1 = FXTextField.new(frame4, 16, password_val, FXDataTarget::ID_VALUE,TEXTFIELD_NORMAL|LAYOUT_FILL_X|LAYOUT_FILL_COLUMN)
password_val.connect(SEL_COMMAND)do
    $password_full = password_val
end
#=========================================================================



#The login button, if no credentials entered load credentials from email.txt and passwords.txt
login_button = FXButton.new(frame4, "Login", nil, application, FXApp::ID_QUIT)
login_button.connect(SEL_COMMAND)do
    login_controller = Login.new
    if $password_full == nil
        t1 = Thread.new{login_controller.login_system($account_email,$password_full,true)}
        puts "No value in password_full found, the password value was #{$password_full} "
    else
     
        #puts "There was a value found in password_full of: #{$password_full}"
        login_controller.login_system($account_email,$password_full,false)
    end
    end
#=========================================================================



#second frame in gui
frame2 = FXHorizontalFrame.new(main,
            LAYOUT_LEFT | LAYOUT_CENTER_Y| PACK_UNIFORM_WIDTH|FRAME_GROOVE)

frame_bottom = FXHorizontalFrame.new(main,
    LAYOUT_TOP | LAYOUT_CENTER_Y| PACK_UNIFORM_WIDTH|FRAME_GROOVE)

#Check out button
repair_button = FXButton.new(frame_bottom, "Repair", nil, application, FXApp::ID_QUIT)
repair_button.connect(SEL_COMMAND)do
end


# Add Asset Button
add_asset_button = FXButton.new(frame2, "Add Asset", nil, application, FXApp::ID_QUIT,)
add_asset_button.connect(SEL_COMMAND)do
    asset_controller.full_add_and_save

end


#Check out button
check_out_button = FXButton.new(frame2, "Check Out Item", nil, application, FXApp::ID_QUIT)
check_out_button.connect(SEL_COMMAND)do
end


delete_asset_button = FXButton.new(frame2, "Reset Password", nil, application, FXApp::ID_QUIT)
delete_asset_button.connect(SEL_COMMAND)do
    login_controller = Login.new
    login_controller.reset_password
end
change_group_button = FXButton.new(frame2, "Exit Program", nil, application, FXApp::ID_QUIT)
#===========================================================================




application.create()
main.show(PLACEMENT_SCREEN)
application.run()