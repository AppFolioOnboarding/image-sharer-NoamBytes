require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  # test 'we have an input for a URL' do
  def test_new
    get new_image_url

    assert_equal 200, status
    assert_select 'h1', 'New Image'
    assert_select '#image_url'
    assert_select '#image_tag_list'
  end

  def test_create__valid_url
    assert_difference('Image.count', 1) do
      post images_url, params: { image: { url: 'http://google.com' } }
    end

    assert_equal Image.last.url, 'http://google.com'
    assert_equal Image.last.tag_list, []
    assert_redirected_to "/images/#{Image.last.id}"
  end

  def test_create__invalid_url
    assert_no_difference('Image.count') do
      post images_url, params: { image: { url: 'notavalidurl' } }
    end
  end

  def test_create__valid_url_with_tags
    assert_difference('Image.count', 1) do
      post images_url, params: { image: { url: 'http://google.com', tag_list: 'website, google' } }
    end

    assert_equal Image.last.url, 'http://google.com'
    assert_equal Image.last.tag_list, %w[website google]
    assert_redirected_to "/images/#{Image.last.id}"
  end

  def test_show
    image = Image.create(url: 'http://whatever.com', tag_list: 'whatever')

    get image_url(image.id)

    assert_response :success
    assert_select 'img', 1
    assert_select 'p', 'whatever'
  end

  def test_search
    Image.create(url: 'http://google.com', tag_list: 'website, google')
    Image.create(url: 'http://someotherwebsite.com', tag_list: 'website')
    Image.create(url: 'http://notawebsite.com', tag_list: 'nonwebsite')

    get search_path('website')

    assert_response :success
    assert_select 'h1', 'Images tagged with website'
    assert_select 'img', 2
  end

  def test_search__no_results
    # if there are no images there will never be a result
    get search_path('somequery')

    assert_response :success
    assert_select 'h1', 'No images were tagged with somequery'
    assert_select 'img', 0
  end

  def test_destroy
    image = Image.create(url: 'http://someotherwebsite.com', tag_list: 'website')

    assert_difference('Image.count', -1) do
      delete image_url(image.id)
    end
    assert_response :found
    assert_redirected_to '/'
    assert_nil Image.find_by(id: image.id)
  end

  def test_destroy__non_existent
    delete image_url(9)

    assert_response :unprocessable_entity
    assert_equal 'ID not found and cannot be deleted', JSON.parse(response.body)['message']
  end

  test 'displays the correct number of images on homepage' do
    Image.create(url: 'http://whatever.com')
    Image.create(url: 'http://whatever.com')

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
    Image.create(url: 'http://whatever.com', tag_list: 'whatever')
    last_image = Image.create(url: 'http://google.com', tag_list: 'website, google')
    all_tags = %w[website google whatever]

    get images_url

    assert_select 'img', 2 do |elements|
      assert_equal last_image.url, elements[0][:src]
    end
    assert_select '#tag-link' do |elements|
      elements.each.with_index do |element, i|
        assert_equal all_tags[i], element.text
        assert_equal "/images/search/#{all_tags[i]}", element[:href]
      end
    end
    assert_select '.delete-button', 2
  end
end
