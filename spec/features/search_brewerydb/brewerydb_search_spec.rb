require 'spec_helper'
require 'rails_helper'

#RAILS_ENV=test foreman run bundle exec rspec spec

describe "Beer home page" do
  before(:all) do
    Capybara.current_driver = :webkit
  end

  it "displays Beer Lookup" do
    visit "/"

    expect(page).to have_title('Beerapp')
    expect(page).to have_content('Beer Lookup')
  end

  it "displays list items after search", :js => true do
    visit "/"
    fill_in "q", with: "sam adams"

    keypress = "var e = $.Event('keydown', { keyCode: 13 }); $('input.search').trigger(e);"
    page.driver.execute_script(keypress)

    expect(page).to have_selector("li.beer")
  end

  it "displays no results found", :js => true do
    visit "/"
    fill_in "q", with: "beer"

    keypress = "var e = $.Event('keydown', { keyCode: 13 }); $('input.search').trigger(e);"
    page.driver.execute_script(keypress)

    expect(page).to have_content("Your search returned no results. :(")
  end

  it "displays error message with an empty search", :js => true do 
    visit "/"

    keypress = "var e = $.Event('keydown', { keyCode: 13 }); $('input.search').trigger(e);"
    page.driver.execute_script(keypress)

    expect(page).to have_selector("div.error")
  end

  after(:all) do
    Capybara.use_default_driver
  end
end
