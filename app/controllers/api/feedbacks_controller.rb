module Api
  class FeedbacksController < ApplicationController
    def create
      feedback = Feedback.new(feedback_params)
      is_saved = feedback.save

      if is_saved
        render json: { 'message': 'Feedback successfully saved!' }, status: :ok
      else
        render json: { 'message': 'Feedback was unable to save' }, status: :unprocessable_entity
      end
    end

    def feedback_params
      params.require(:feedback).permit(:name, :comments)
    end
  end
end
