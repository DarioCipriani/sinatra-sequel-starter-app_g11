require File.expand_path  '../../test_helper.rb', __FILE__

	class QuestionTest < MiniTest::Unit::TestCase

		# Me aseguro que una question tiene muchas choices --> SI y NO por ejemplo
		def test_question_has_many_choices
			# Arrange
			question = Question.create(name:'Me iría a una Zona Agricola.', number:1, type:'radio', description:'1')
			# Act
			choice = Choice.create(text:'SI',question_id: question.id)
			choice2 = Choice.create(text:'NO',question_id: question.id)
			#Assert
			assert_equal(question.choices.count, 2)
			# lo destruyo para que luego no me falle el test diciendo que ese name ya esta creado esto es por el unique
			choice.destroy
			choice2.destroy
			question.destroy
		end

		# Me aseguro que una question tiene muchas responses
		# por ejemplo para la encuesta1 del user1 la respuesta fue si a la pregunta question
		# y para la encuesta 2 el User2 respondio tambien si a la misma pregunta
        def test_question_has_many_responses
        	# Arrange
			question = Question.create(name:'Me gusta conocer los Procesos de las Empresas.', number:1, type:'radio', description:'1')
			survey = Survey.create(username: 'User1')
			survey2 = Survey.create(username: 'User2')
			choice = Choice.create(text:'SI',question_id: question.id)
			# Act
			response = Response.create(question_id: question.id,choice_id: choice.id, survey_id: survey.id)
			response2 = Response.create(question_id: question.id,choice_id: choice.id, survey_id: survey2.id)
			#Assert
			assert_equal(question.responses.count, 2)
			# lo destruyo para que luego no me falle el test diciendo que ese name ya esta creado esto es por el unique
			response.destroy
			response2.destroy
			choice.destroy
			question.destroy

		end

		#me aseguro que el name no es nulo ni vacio
		def test_question_has_name
			# Arrange
			question = Question.new
			# Act
			question.name = ''
			# Assert
			assert_equal question.valid?, false
		end

		#me aseguro que el type no es nulo ni vacio
		def test_question_has_type
			# Arrange
			question = Question.new
			# Act
			question.name = 'name'
			question.type = ''
			# Assert			
			assert_equal question.valid?, false
		end

		 #Me aseguro que no pueden existir preguntas duplicadas
		def test_questions_has_one_name
	      # Arrange
	      name = 'Tengo buena memoria y no me cuesta estudiar.'
	      number = 1
	      type = 'radio'
	      description = '1'	      	      
	      # Act
	      question = Question.new(name: name, number: number, type: type, description: description)
		  question_duplicated = Question.new(name: name, number: number, type: type, description: description)
	      # Assert
	      assert question.save
	      #Si la función save genera la excepción esperada (ValidationFailed), la aserción pasa.
	      assert_raises(Sequel::ValidationFailed) { question_duplicated.save() } # seria como assert_equal(falla, question_duplicated.save() )
	      # lo destruyo para que luego no me falle el test diciendo que ese name ya esta creado esto es por el unique
	      question.destroy
	    end
	end