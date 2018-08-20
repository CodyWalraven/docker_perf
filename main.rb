require_relative 'asset.rb'
require_relative 'login.rb'

$CREDS = "staging:q[q9:S2w+M"
$ENV = "refactoring"

$URL = "https://#{$CREDS}@www.#{$ENV}.assetpanda.com"


login_control = Login.new
asset_control = Asset.new



login_control.login_system($account_email, $password, true)
asset_control.full_add_and_save