require 'spec_helper'
require 'rails_helper'

#RAILS_ENV=test foreman run bundle exec rspec spec

describe "Beer home page" do
  before(:all) do
    Capybara.current_driver = :webkit
  end

  def enter_search(search = "autumn")
    visit "/"
    fill_in "q", with: search

    keypress = "var e = $.Event('keydown', { keyCode: 13 }); $('input.search').trigger(e);"
    page.driver.execute_script(keypress)
  end


  it "displays a title, Beer Lookup and a search field " do
    visit "/"

    expect(page).to have_title('Beerapp')
    expect(page).to have_content('Beer Lookup')
    expect(page).to have_selector('input.search')
  end

  it "displays list items after search", :js => true do
    enter_search
    expect(page).to have_selector("li.beer")
  end

  it "displays no results found", :js => true do
    enter_search("beer")
    expect(page).to have_content("Your search returned no results. :(")
  end

  it "displays error message with an empty search", :js => true do 
    enter_search(" ")
    expect(page).to have_selector("div.error")
  end

  it "displays a single beer when more info button clicked", :js => true do
  end

  after(:all) do
    Capybara.use_default_driver
  end
end
