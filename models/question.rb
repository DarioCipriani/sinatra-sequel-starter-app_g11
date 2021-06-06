class Question < Sequel::Model
	one_to_many :responses
	one_to_many :choices

	def validate
    	super
   		errors.add(:name, 'cannot be empty') if !name || name.empty?
   		errors.add(:type, 'cannot be empty') if !type || type.empty?

  	end

end