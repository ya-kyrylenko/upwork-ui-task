class ResultPage < Page
  def open_filters_list
    filter_path = "//div[@data-ng-disabled='!$ctrl.parentCtrl.isLoaded']"\
                  "[contains(.,'Filters')]"
    wait = Selenium::WebDriver::Wait.new(timeout: 15)
    filters_button = wait.until do
      filters_element = @driver.find_element(:xpath, filter_path)
      filters_element if filters_element.displayed?
    end
    filters_button.click
  end

  def select_category(title)
    @driver.find_element(:xpath, "//label[contains(.,'#{title}')]").click
  rescue Selenium::WebDriver::Error::NoSuchElementError
    @driver.find_element(:link, "See all categories").click
    @driver.find_element(:xpath, "//a[text()='#{title}']").click
  end

  def select_label_by_title(title)
    rate_label = @driver.find_element(:xpath, "//label[contains(.,'#{title}')]")
    rate_label.click
  end

  def wait_filters_applied
    @driver.find_element(:xpath, "//span[text()='Filters applied']")
  end

  def find_freelancers
    freelancers_section_path = "section[data-log-sublocation='search_results']"
    @driver.find_elements(:css, freelancers_section_path)
  end

  def verify_freelancer_titles(freelancers, keyword, amount)
    verifiable_freelancers = freelancers.first(amount)
    verifiable_freelancers.each do |f_info|
      f_title = f_info.find_element(:class_name, "freelancer-tile-title").text
      error_message = "Keyword '#{keyword}' not present in first #{amount} "\
                      "freelancer seatch results"
      raise error_message unless f_title[/#{keyword}/i] 
    end
  end

  def go_to_freelancer_page(freelancer)
    freelancer.find_element(:class_name, 'freelancer-tile-name').click
  end
end
