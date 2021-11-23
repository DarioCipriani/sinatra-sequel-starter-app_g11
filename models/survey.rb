# frozen_string_literal: true

# encuesta final
class Survey < Sequel::Model
  plugin :timestamps # agrega la visibilidad de las columnas de update_at y created_at al modelo
  many_to_one :careers
  one_to_many :responses

  def validate
    super
    errors.add(:username, 'cannot be empty') if !username || username.empty?
    validates_unique :username 	# nos aseguramos que solo exista una encuesta asociada a un usuario
  end
end
