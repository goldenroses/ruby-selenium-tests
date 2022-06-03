require 'selenium-webdriver'
require 'test-unit'

class  EcommerceTests < Test::Unit::TestCase
  def setup
    @my_driver = Selenium::WebDriver.for :firefox
    @url = "https://ecommerce-playground.lambdatest.io/"
    
    #get url
    @my_driver.get(@url)
    @my_driver.manage.timeouts.implicit_wait = 30

    @wait = Selenium::WebDriver::Wait.new(:timeout => 7)

  end

  def test_search_functionality_should_yield_results

    @wait.until{@my_driver.title.include? "Your Store"}

    search_box = @my_driver.find_element(:name, "search")
    # First test assertion - title has loaded
    assert_equal("Your Store", @my_driver.title.to_s)

    search_box.clear
    search_box.send_keys("phone")
    search_box.submit
    sleep(5)
    search_title = @my_driver.find_element(:xpath, '//*[@id="entry_212456"]/h1').text

    # Second test assertion - title has loaded
    assert_equal("Search - phone", search_title)
  end

  def teardown
    @my_driver.quit
  end

end