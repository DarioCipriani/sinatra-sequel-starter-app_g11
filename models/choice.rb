class Choice < Sequel::Model
	one_to_many :outcomes
	one_to_one :responses
	many_to_one :questions
	def validate
    	super
   		errors.add(:text, 'cannot be empty') if !text || text.empty?
  	end
end