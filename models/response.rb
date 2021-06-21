class Response < Sequel::Model
	many_to_one :surveys
	many_to_one :questions
	one_to_one :choises
	# me aseguro que una misma choice_id,question_id y survey_id no esten duplicados
	def validate
    super
    	validates_unique [:choice_id, :question_id, :survey_id] 
    end
end