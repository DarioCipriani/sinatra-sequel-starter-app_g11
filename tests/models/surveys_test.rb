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

  
  #Este test verifica si existes 2 Survey con el mismo username
#  def test_survey_one_username
#    # Arrange
#    career = Career.create(name:'Fisica')
#
#    # Act
#    survey = Survey.create(username: 'Cristian', career_id: career.id)
#    survey1 = Survey.create(username: 'Cristian', career_id: career.id)
#    # Assert
#    assert_equal(Survey.where(username: survey.username).count, 1)
#
#    # lo destruyo para que luego no me falle el test diciendo que ese username ya esta 
#    career.destroy
#    survey.destroy
#    survey1.destroy
#  end

  #Como resultado deja crear 2 Survey con el mismo username, entonces colocamos la resticcion validates_unique :username en Survey.rb, pero
  # al ejecutar nuevamente el test nos da una excepcion ValidationFailed: username is already taken (usuario existente) y por ello 
  # comentamos este test y creamos el test siguiente para probarlo de otra forma, es decir probarlo con el 
  # assert_raises(Sequel::ValidationFailed) que es una assert que trabaja con excepciones


  def test_survey_one_username
    # Arrange
    career = Career.create(name:'Fisica')     
    # Act
    survey = Survey.new(username: 'Cristian', career_id: career.id)
    survey_duplicated = Survey.new(username: 'Cristian', career_id: career.id)
    # Assert
    assert survey.save
    #Si la función save genera la excepción esperada (ValidationFailed), la aserción pasa.
    assert_raises(Sequel::ValidationFailed) { survey_duplicated.save() } # seria como assert_equal(ValidationFailed, survey_duplicated.save() 
    #y como survey_duplicated.save() lanza una excepcion ValidationFailed entonces retorna true
    # lo destruyo para que luego no me falle el test diciendo que ese username ya esta creado esto es por el validates_unique
    survey.destroy
    career.destroy
  end

end