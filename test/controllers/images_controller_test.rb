require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  def test_new
    get new_image_url

    assert_equal 200, status
    assert_select 'h1', 'New Image'
    assert_select '#image_url'
  end
end
