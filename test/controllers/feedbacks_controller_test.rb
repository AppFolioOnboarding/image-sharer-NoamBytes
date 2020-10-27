require 'test_helper'

class FeedbacksControllerTest < ActionDispatch::IntegrationTest
  def test_create_valid
    assert_difference('Feedback.count', 1) do
      post api_feedbacks_url, params: { feedback: { name: 'SomeName', comments: 'blah blah' } }
    end
    assert_response :success
    assert_equal JSON.parse(response.body), 'message' => 'Feedback successfully saved!'
  end

  def test_create_invalid
    assert_no_difference('Feedback.count') do
      post api_feedbacks_url, params: { feedback: { name: '', comments: '' } }
    end
    assert_response :unprocessable_entity
    assert_equal JSON.parse(response.body), 'message' => 'Feedback was unable to save'
  end
end
