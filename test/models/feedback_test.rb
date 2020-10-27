require 'test_helper'

class FeedbackTest < ActiveSupport::TestCase
  def test_valid_name_and_comment
    feedback = Feedback.new(name: 'SomeName', comments: 'blah blah')

    assert_difference('Feedback.count', 1) do
      feedback.save
    end
  end

  def test_invalid_name_and_comment
    feedback = Feedback.new(name: '', comments: '')

    assert_no_difference 'Feedback.count' do
      feedback.save
    end
    assert_equal feedback.errors.messages[:name].first, "can't be blank"
    assert_equal feedback.errors.messages[:comments].first, "can't be blank"
  end

  def test_invalid_name_only
    feedback = Feedback.new(name: '', comments: 'blah blah')

    assert_no_difference 'Feedback.count' do
      feedback.save
    end
    assert_equal feedback.errors.messages[:name].first, "can't be blank"
  end

  def test_invalid_comments_only
    feedback = Feedback.new(name: 'AName', comments: '')

    assert_no_difference 'Feedback.count' do
      feedback.save
    end
    assert_equal feedback.errors.messages[:comments].first, "can't be blank"
  end
end
