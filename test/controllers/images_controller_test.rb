require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  def test_new
    get new_image_url

    assert_equal 200, status
    assert_select 'h1', 'New Image'
    assert_select '#image_url'
  end

  def test_create__valid_url
    assert_difference("Image.count", 1) do
      post images_url, params: {image: {url: "www.google.com"}}
    end

    assert_equal Image.last.url, "www.google.com"
    assert_redirected_to "/images/#{Image.last.id}"
  end

  def test_create__invalid_url
    assert_no_difference("Image.count") do
      post images_url, params: {image: {url: "notavalidurl"}}
    end
  end

  def test_show
    image = Image.create({url: "www.whatever.com"})

    get image_url(image.id)

    assert_response :success
    assert_select 'img', 1
  end
end
