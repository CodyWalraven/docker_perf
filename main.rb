require_relative 'asset.rb'
require_relative 'login.rb'

login_control = Login.new
asset_control = Asset.new



$ENV = login

login_control.login_system($account_email, $password, true)
asset_control.full_add_and_save