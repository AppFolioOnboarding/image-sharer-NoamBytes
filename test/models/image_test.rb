require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  def test_valid_url
    image = Image.new(url: 'www.google.com')

    assert_difference'Image.count', 1 do
      image.save
    end
  end

  def test_invalid_url
    image = Image.new(url: 'notvalid')

    assert_no_difference'Image.count' do
      image.save
    end
    assert_equal image.errors.messages[:url].first, 'not a valid URL'
  end

  def test_empty_url
    image = Image.new(url: '')

    assert_no_difference'Image.count' do
      image.save
    end
    assert_equal image.errors.messages[:url].first, "can't be blank"
  end
end
