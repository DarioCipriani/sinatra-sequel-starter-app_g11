# frozen_string_literal: true

require './models/response'
require './models/init'

# SurveyService
class SurveyService
  def self.create_responses(data, survey_id)
    data.each do |d|
      response = Response.create(choice_id: d['choiceId'], question_id: d['questionId'], survey_id: survey_id)
      response.save
    end
  end
end
