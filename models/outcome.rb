Sequel::Model.plugin :validation_helpers
class Outcome < Sequel::Model
	many_to_one :careers
	many_to_one :choises

	# me aseguro que una misma choice_id y una misma career_id no esten duplicados
	def validate
    super
    	validates_unique [:choice_id, :career_id] 
    end
end