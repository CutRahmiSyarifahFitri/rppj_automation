Then('user navigates to the CP master data page') do
  p 'Navigating to CP Master Data page...'
  @pages.CheckPoint.load
  p 'Loaded CP Master Data page!'
  
  if @pages.CheckPoint.has_cp_title?
    p 'Title found: CP Master Data'
  else
    raise 'Title not found: CP Master Data'
  end
  expect(@pages.CheckPoint).to have_cp_title(wait: 10)
end 


Then('I click the add CP button') do
  waiting_for_page_ready
  p 'Clicking the add CP button...'
  @pages.CheckPoint.add_cp_button.click(wait: 10)
end

And('I fill in the CP name {string}') do |cp_name|
  waiting_for_page_ready
  p 'Waiting for CP name input to be visible...'
  @pages.CheckPoint.wait_until_cp_name_input_visible
  @pages.CheckPoint.cp_name_input.set(cp_name)
  
end

And('I select the CP order {int}') do |cp_order|
  waiting_for_page_ready
  p "Selecting Unit Type for CP Order: #{cp_order}"

  # Panggil method untuk memilih tipe unit
  @pages.CheckPoint.select_unit_type(cp_order)

  p "Urutan CP for CP Order '#{cp_order}' selected successfully!"
end


Then('I select the unit type {string}') do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

Then('I enter the maximum capacity {string}') do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

Then('I add a device and item ID {string} {string}') do |string, string2|
  pending # Write code here that turns the phrase above into concrete actions
end

Then('I fill in the comment for the reason {string}') do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

Then('I fill in the comment in the reason area {string}') do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

Then('the CP {string} should be successfully added') do |string|
  pending # Write code here that turns the phrase above into concrete actions
end