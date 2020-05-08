module Users
  module Operations
    class Create < Core::Operation
      def initialize(params,
        input_validator: Users::Validators::NewUserContract.new,
        model: User
      )
        @params = params
        @input_validator = input_validator
        @model = model
      end

      def call
        yield input_validate
        save
      end

      private

      attr_reader :params, :model, :input_validator

      def input_validate
        input_validator.call(params).to_monad
      end

      def save
        Try() { model.create!(params) }
      end
    end
  end
end
