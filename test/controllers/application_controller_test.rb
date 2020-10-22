require 'test_helper'

class ApplicationControllerTest < ActionDispatch::IntegrationTest
  test 'returns a 200 response' do
    get '/'

    assert_equal 200, status
    assert_select 'h1', 'Image Sharer'
    assert_select 'a[href=?]', '/images/new'
  end
end
