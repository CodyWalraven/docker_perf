require_relative 'asset.rb'
require_relative 'login.rb'

$CREDS = "staging:q[q9:S2w+M"
$ENV = "login"

# staging:q[q9:S2w+M@www.refactoring.assetpanda.com

$headless = true




login_control = Login.new
asset_control = Asset.new

login_control.login_system($account_email, $password, true)
asset_control.full_add_and_save