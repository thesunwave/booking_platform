module Users
  module Validators
    class NewUserContract < Dry::Validation::Contract
      params do
        required(:email).filled(:string)
      end

      rule(:email) do
        unless /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.match?(value)
          key.failure('has invalid format')
        end
      end
    end
  end
end
