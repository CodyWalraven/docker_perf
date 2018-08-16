require "selenium-webdriver"

class Asset
    def initialize    
    end

    def click_assets
        $driver.navigate.to "https://login.assetpanda.com/asset_items"       
    end

    def click_add_new_asset
        $driver.navigate.to "https://login.assetpanda.com/asset_items/new"
    end

    def slice_brackets(string)
      string.slice!(0,2)
      string.slice!(-1)
      string.slice(-1)
      string.lstrip!
    end

    def input_asset_info(name)

        #Read last asset id from file and convert the value to a string
        @last_asset_id = File.readlines 'last_asset_id.txt'
        @last_asset_id.each_with_index{|line, i| puts "#{i+1}: #{line}"}
        incremented_asset_id = @last_asset_id.to_s


        #Strip off the brackets and quotes so its just the digit for to_i to work right.
        incremented_asset_id.slice!(0,2)
        incremented_asset_id.slice!(-1)
        incremented_asset_id.slice!(-1)
        incremented_asset_id.lstrip!
   
        #Convert the value to an integer, add 1, then save results to the same file
        incremented_asset_id = incremented_asset_id.to_i
        incremented_asset_id += 1
        File.write('last_asset_id.txt', incremented_asset_id)



        #Sent over the information to the Asset id and name field
        asset_id_field = $driver.find_element(name: 'values[field_1]')
        name_field = $driver.find_element(name: 'values[field_3]')
        name_field.send_keys(name)
        asset_id_field.send_keys(incremented_asset_id)   
    end

    def save
        #This really just presses enter, but eh it saves the item
        $driver.action.send_keys(:enter).perform
    end

    def full_add_and_save
        click_add_new_asset
        input_asset_info("Test Item")
        save
    end

end




