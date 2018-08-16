require_relative 'asset.rb'
require_relative 'login.rb'

asset_control = Asset.new
login_control = Login.new


login_control.login_system($account_email, $password, true)
asset_control.full_add_and_save