require File.expand_path  '../../test_helper.rb', __FILE__

class ResponseTest < MiniTest::Unit::TestCase
	# Me aseguro que para una encuesta solo tenga una respuesta por pregunta
	def test_response_has_one_survey
		# Arrange
			survey = Survey.create(username: 'user1')
			question = Question.create(name:'Me gusta conocer los Procesos de las Empresas.', number:1, type:'radio', description:'1')
			choice = Choice.create(text:'SI',question_id: question.id)
			# Act
			response = Response.new(question_id: question.id,choice_id: choice.id, survey_id: survey.id)
			response_duplicated = Response.new(question_id: question.id,choice_id: choice.id, survey_id: survey.id)
			# Assert			
			assert response.save
			#Si la función save genera la excepción esperada (ValidationFailed), la aserción pasa.
	        assert_raises(Sequel::ValidationFailed) { response_duplicated.save() } # seria como assert_equal(falla, response_duplicated.save() )
			
			# lo destruyo para que luego no me falle el test diciendo que ese name ya esta creado esto es por el unique
			response.destroy
			choice.destroy
			question.destroy
        
    end
end