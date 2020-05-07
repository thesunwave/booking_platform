# frozen_string_literal: true

module Core
  class Operation
    include Dry::Monads[:try, :result, :do]

    def call(*)
      raise NotImplementedError
    end
  end
end
