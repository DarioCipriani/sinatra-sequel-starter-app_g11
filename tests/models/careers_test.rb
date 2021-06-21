require File.expand_path '../../test_helper.rb', __FILE__

class CareerTest < MiniTest::Unit::TestCase
	MiniTest::Unit::TestCase

	# con este Test me aseguro que 1 Career (carrera) puede tener mas de 1 survey (Encuesta)
	def test_carrer_has_many_surveys
		# Arrange
		career = Career.create(name: 'computacion')

		# Act
		Survey.create(username: '1', career_id: career.id)
		Survey.create(username: '2', career_id: career.id)
		Survey.create(username: '3', career_id: career.id)

		# Assert
		assert_equal(career.surveys.count, 3)

	end

    #Con este test me aseguro que 1 carrera puede estar asociada a mas de una resultado (Outcome)
	def test_career_has_many_outcomes
		# Arrange
		career = Career.create(name:'computacion')
		question = Question.create(name:'Me trasladaría a una zona agrícola - ganadera para ejercer mi profesión.', number:1, type:'radio', description:'1')
		choice = Choice.create(text:'SI',question_id: question.id)
		# Act
		Outcome.create(career_id: career.id, choice_id: choice.id)
		Outcome.create(career_id: career.id, choice_id: choice.id)
		Outcome.create(career_id: career.id, choice_id: choice.id)
		Outcome.create(career_id: career.id, choice_id: choice.id)
	    Outcome.create(career_id: career.id, choice_id: choice.id)
		Outcome.create(career_id: career.id, choice_id: choice.id)

		# Assert
		assert_equal(career.outcomes.count, 6)
	end

#con este test me asuguro que el nombre de una carrera nunca sea la cadena vacia
	def test_career_has_name_validator
		# Arrange
		career = Career.new


		# Act
		career.name = ''

		# Assert
		assert_equal career.valid?, false
	end
end
