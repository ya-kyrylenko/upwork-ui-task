class HomePage < Page
  def visit_home_page
    @driver.manage.delete_all_cookies
    @driver.get "https://www.upwork.com/"
  end

  def search_freelancers(keyword)
    find_input = @driver.find_element(:css, "input[placeholder='Find Freelancers']")
    find_input.send_keys keyword
    find_input.submit
  end
end
