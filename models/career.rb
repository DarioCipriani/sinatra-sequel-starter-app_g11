class Career < Sequel::Model
	one_to_many :surveys
end