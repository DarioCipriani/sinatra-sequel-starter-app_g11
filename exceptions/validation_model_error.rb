# frozen-string-literal: true

class ValidationModelError
  module Error
    # Exception class raised when +raise_on_save_failure+ is set and an action is canceled in a hook.
    # or an around hook doesn't yield.
    class ValidationModelError < Error
      def message
        'Error'
      end
    end

    # AlreadyExist
    class AlreadyExist < Error
      def message
        'Carrera ya creada'
      end
    end
  end
end
