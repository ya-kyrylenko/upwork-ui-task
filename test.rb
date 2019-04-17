require 'selenium-webdriver'
require './pages/page.rb'
require './pages/resultpage.rb'
require './pages/homepage.rb'
require './pages/profilepage.rb'

begin
  KEYWORD        = 'Ruby'
  CATEGORY_TITLE = 'Web, Mobile & Software Dev'
  RATE_TITLE     = '$10 and below'

  driver = Selenium::WebDriver.for :firefox
  driver.manage.timeouts.implicit_wait = 10
  page = HomePage.new(driver)
  puts "Go to 'https://www.upwork.com/'"
  page.visit_home_page
  puts "Type keyword '#{KEYWORD}' in Find Freelancer search box"
  page.search_freelancers(KEYWORD)
  page = ResultPage.new(driver)
  page.open_filters_list
  puts "Select category #{CATEGORY_TITLE}"
  page.select_category(CATEGORY_TITLE)
  puts "Select hourly rate #{RATE_TITLE}"
  page.select_label_by_title(RATE_TITLE)
  page.wait_filters_applied
  freelancers = page.find_freelancers
  puts 'Verify that first 3 freelancers has the keyword in their title'
  page.verify_freelancer_titles(freelancers, KEYWORD, 3)
  puts 'Click on second freelancer to open profile'
  page.go_to_freelancer_page(freelancers[1])
  page = ProfilePage.new(driver)
  puts 'Verify that the keyword is presented in title and in description'
  page.verify_title(KEYWORD)
  page.verify_description(KEYWORD)
  puts 'Verify that freelancer\'s hourly rate match search criteria'
  page.verify_price_range
ensure
  driver.quit unless driver.nil?
end
