class ProfilePage < Page
  def verify_title(keyword)
    title_css_path = '.up-active-context-title'
    error_message = "Keyword '#{keyword}' is not present in title on "\
                    "freelancer profile"
    check_presence_of_keyword(title_css_path, keyword, error_message)
  end

  def verify_description(keyword)
    desc_css_path = "p[itemprop='description']"
    error_message = "Keyword '#{keyword}' is not present in description on "\
                    "freelancer profile"
    check_presence_of_keyword(desc_css_path, keyword, error_message)
  end

  def verify_price_range
    price_path = "//li[contains(., 'Hourly rate')]//span[@itemprop='pricerange']"
    price = @driver.find_element(:xpath, price_path).text.gsub('$', '').to_f
    error_message = 'Hourly rate don\'t match search criteria'
    raise error_message unless price.between?(0, 10)
  end

  ##############################################################################
  private

  def check_presence_of_keyword(css_path, keyword, error_message)
    element_text = @driver.find_element(:css, css_path).text
    raise error_message unless element_text[/#{keyword}/i]
  end
end
