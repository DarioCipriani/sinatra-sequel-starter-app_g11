require File.expand_path '../test_helper.rb', __dir__

# prueba de la clase opciones
class ChoicesTest < MiniTest::Unit::TestCase
  # En este test me aseguro que el texto de una opcion nunca sea vacio
  def test_choices_must_has_text
    # Arrange
    choice = Choice.new
    # Act
    choice.text = ''
    # Assert
    assert_equal choice.valid?, false
  end

  # En este test me aseguro que una opcion puede estar asociada a muchos resultados, es decir por ejemplo
  # si se selecciona la opcion 'Si', esta respuesta va a estar asociada a 3 carreras distintas
  # por lo que cuando se calcule el peso de esa respuesta cada carrera tendra un 1 adicional en el arreglo de pesos
  def test_choices_has_many_outcomes
    # Arrange
    career = Career.create(name: 'computación')
    career1 = Career.create(name: 'agronomía')
    career2 = Career.create(name: 'periodismo')
    question = Question.create(name: 'Me trasladaría a una zona Agricola.', number: 1, type: 'radio', description: '1')
    choice = Choice.create(text: 'SI', question_id: question.id)
    # Act
    outcome = Outcome.create(career_id: career.id, choice_id: choice.id)
    outcome1 = Outcome.create(career_id: career1.id, choice_id: choice.id)
    outcome2 = Outcome.create(career_id: career2.id, choice_id: choice.id)
    # Assert
    assert_equal(choice.outcomes.count, 3)

    # lo destruyo para que luego no me falle el test diciendo que ese name ya esta creado esto es por el unique
    outcome1.destroy
    outcome.destroy
    outcome2.destroy
    choice.destroy
    question.destroy
    career.destroy
    career1.destroy
    career2.destroy
  end

  # En este test me aseguro que una opcion tiene una question_id asociada
  def test_choices_has_question
    # Arrange
    career = Career.create(name: 'quimica')
    # Act
    question = Question.create(name: 'Me trasladaría a una zona agrícola-ganadera', number: 1, type: 'radio',
                               description: '1')
    choice = Choice.create(text: 'SI', question_id: question.id)
    # Assert
    assert_equal(choice.question_id.nil?, false)

    # lo destruyo para que luego no me falle el test diciendo que ese name ya esta creado esto es por el unique
    choice.destroy
    question.destroy
    career.destroy
  end
end
