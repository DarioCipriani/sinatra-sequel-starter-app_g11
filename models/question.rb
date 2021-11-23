# frozen_string_literal: true

# Preguntas que corresponden a la encuesta
class Question < Sequel::Model
  one_to_many :responses
  one_to_many :choices
  # si el type o el name son nulos o tienen la cadena vacia falla mostrando el error: cannot be empty
  def validate
    super
    errors.add(:name, 'cannot be empty') if !name || name.empty?
    errors.add(:type, 'cannot be empty') if !type || type.empty?
    validates_unique :name
  end
end
