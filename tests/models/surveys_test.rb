require File.expand_path '../../test_helper.rb', __FILE__

class SurveyTest < MiniTest::Unit::TestCase
  MiniTest::Unit::TestCase

  # Este test se asegura que el username no sea nulo o vacio al crear el survey, 
  # pero la carrera puede ser nula porque cuando creamos el survey en nuestro proyecto 
  # solo desp de calcular los resultados le asignamos el id de la carrera que gano.
  def test_survey_must_has_username
    # Arrange
    survey = Survey.new
    # Act
    survey.username = ''
    # Assert
    assert_equal survey.valid?, false
  end
  
end