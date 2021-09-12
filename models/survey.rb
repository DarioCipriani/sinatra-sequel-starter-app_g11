class Survey < Sequel::Model
	many_to_one :careers
	one_to_many :responses

	def validate
    	super
   		errors.add(:username, 'cannot be empty') if !username || username.empty? #nos aseguramos el username no sea nulo ni vacio
   		validates_unique :username 	#nos aseguramos que solo exista una encuesta asociada a un usuario
  	end
end