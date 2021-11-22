require './models/response.rb'
require './models/init.rb'

class SurveyService

  def self.create_responses(data, survey_id)
    data.each do |d|
      response = Response.create(choice_id: d['choiceId'], question_id: d['questionId'], survey_id: survey_id)
      response.save
    end
  end

end
