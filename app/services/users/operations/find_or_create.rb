module Users
  module Operations
    class FindOrCreate < Core::Operation
      def initialize(model: User, validator: Users::Validators::NewUserContract.new)
        @model = model
        @validator = validator
      end

      def call(payload)
        validated_params = yield validator.call(payload).to_monad
        Try() { model.find_by(validated_params.to_h) || model.create!(validated_params.to_h) }.to_result
      end

      private

      attr_reader :model, :validator
    end
  end
end
