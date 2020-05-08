module Users
  module Operations
    class CheckExists < Core::Operation
      def initialize(email, model: User)
        @email = email
        @model = model
      end

      def call
        return Success(model.find_by(email: email)) if model.where(email: email).exists?
        Success(:user_not_exists)
      end

      private

      attr_reader :email, :model
    end
  end
end
