require File.expand_patch '../../test_helper.rb', __FILE__

class CareerTest < MiniTest::Unit::TestCase
	MiniTest::Unit::TestCase

	# con este Test me aseguro que 1 Career (carrera) puede tener mas de 1 survey (Cuestionario)
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

    #se podria agregar por ejemplo un test que compruebe que en name de la carrera no sea nulo y que no se repita
end