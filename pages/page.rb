class Page
  def initialize(driver)
    @driver = driver
  end

  def close
    @driver.close
  end
end
