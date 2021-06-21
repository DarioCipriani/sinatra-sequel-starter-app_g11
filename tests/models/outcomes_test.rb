require File.expand_path '../../test_helper.rb', __FILE__

class OutcomTest < MiniTest::Unit::TestCase
    MiniTest::Unit::TestCase

    # Con este test me aseguro que una choise_id y una career_id no estaran duplicadas, este par debe ser unico para outcome
    # para ello en el modelo de outcome puse la restriccion de unique(career_id,choice_id)
    # en este test uso assert_raises: esta función prueba que una llamada a una función en este caso "save" genere una 
    # excepción específica (ValidationFailed) cuando se le presenten ciertos parámetros, en este caso una outcome duplicada.
    # probando de esta manera que se cumple la restriccion unique definida en la clase outcome.
    def test_outcomes_has_one_choice
      # Arrange
      career = Career.create(name:'computación')
      question = Question.create(name:'Me trasladaría a una zona agrícola', number:1, type:'radio', description:'1')
	  choice = Choice.create(text:'SI',question_id: question.id)
      
      # Act
      original_outcome = Outcome.new(career_id: career.id, choice_id: choice.id)
      duplicate_outcome = Outcome.new(career_id: career.id, choice_id: choice.id)
      # Assert
      assert original_outcome.save
      #Si la función save genera la excepción esperada (ValidationFailed), la aserción pasa.
      assert_raises(Sequel::ValidationFailed) { duplicate_outcome.save() } # seria como assert_equal(falla, duplicate_outcome.save() )
      # lo destruyo para que luego no me falle el test diciendo que ese name ya esta creado esto es por el unique
      original_outcome.destroy
      choice.destroy
      question.destroy
      career.destroy
    end
  end