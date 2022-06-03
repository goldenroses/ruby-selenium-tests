require 'selenium-webdriver'
require 'test-unit'

class EcommerceTests < Test::Unit::TestCase
  def setup
    username= "{LAMBDATEST_USERNAME}"
    accessToken= "{LAMBDATEST_ACCESS_KEY}"
    gridUrl = "hub.lambdatest.com/wd/hub"
    username= "makenaroes"
    accessToken= "K924FH6LZsO8JzjHyx0eyYnUb3LElaNbaIcAfB8isWotf0tnE4"
    gridUrl = "hub.lambdatest.com/wd/hub"

    capabilities = {
      'LT:Options' => {
        "user" => username,
        "accessKey" => accessToken,
        "build" => "Ecommerce Test v.1",
        "name" => "Ecommerce Tests",
        "platformName" => "Windows 11"
      },
      "browserName" => "Firefox",
      "browserVersion" => "100.0",
    }


    @my_driver = Selenium::WebDriver.for(:remote,
                                      :url => "https://"+username+":"+accessToken+"@"+gridUrl,
                                      :desired_capabilities => capabilities)
    @url = "https://ecommerce-playground.lambdatest.io/"
    @wait = Selenium::WebDriver::Wait.new(:timeout => 30)

    #get url
    @my_driver.get(@url)

    @my_driver.manage.timeouts.implicit_wait = 30

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
