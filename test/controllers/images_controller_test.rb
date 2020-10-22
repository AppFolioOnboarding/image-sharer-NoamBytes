require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  # test "we have an input for a URL" do
  def test_new
    get new_image_url

    assert_equal 200, status
    assert_select 'h1', 'New Image'
    assert_select '#image_url'
  end

  def test_create__valid_url
    assert_difference('Image.count', 1) do
      post images_url, params: { image: { url: 'www.google.com' } }
    end

    assert_equal Image.last.url, 'www.google.com'
    assert_redirected_to "/images/#{Image.last.id}"
  end

  def test_create__invalid_url
    assert_no_difference('Image.count') do
      post images_url, params: { image: { url: 'notavalidurl' } }
    end
  end

  def test_show
    image = Image.create(url: 'www.whatever.com')

    get image_url(image.id)

    assert_response :success
    assert_select 'img', 1
  end

  test 'displays the correct number of images on homepage' do
    Image.create(url: 'www.whatever.com')
    Image.create(url: 'www.whatever.com')

    get images_url

    assert_equal 200, status
    assert_select 'img', 2
  end

  test 'returns a 200 response on homepage' do
    get images_url

    assert_equal 200, status
    assert_select 'h1', 'Image Sharer'
    assert_select 'a[href=?]', '/images/new'
    assert_select 'img', 0
  end

  test 'displays newest images first on homepage' do
    image1 = Image.create(url: 'www.whatever.com')
    image2 = Image.create(url: 'http://google.com')

    get images_url

    assert_select 'img', 2 do |element|
      assert_equal image2.url, element[0][:src]
    end
  end
end
