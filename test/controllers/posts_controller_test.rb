require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  def test_power_assert_failed
    assert { 'a'.instance_of?('s'.class) }
  end
end
