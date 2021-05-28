class SurveyTest < MiniTest::Unit::TestCase
  MiniTest::Unit::TestCase

  #este test se asegura que el username no sea nulo o vacio
  def test_survey_must_has_username
    # Arrange
    survey = Survey.new
    # Act
    survey.username = ''
    # Assert
    assert_equal survey.valid?, false
  end
  

  def test_survey_has_a_career
    . . .
  end
end