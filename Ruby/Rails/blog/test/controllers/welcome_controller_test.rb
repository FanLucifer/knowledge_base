require 'test_helper'

class WelcomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get welcome_index_url
    assert_response :success
  end

  test 'assert_react_component' do
    get "/welcome"
    assert_equal 200, response.status

    # assert rendered react component and check the props
    assert_react_component "HelloWorld" do |props|
      assert_equal "Hello from react-rails.", props[:greeting]
      assert_equal "react-rails", props[:info][:name]
      assert_select "[class=?]", "hello-world"
    end

    # or just assert component rendered
    assert_react_component "HelloWorld"
  end

end
