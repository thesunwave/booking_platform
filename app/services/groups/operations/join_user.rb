module Groups
  module Operations
    class JoinUser < Core::Operation
      def initialize(
        input_validator: Users::Validators::NewUserContract.new,
        user_finder: Users::Operations::FindOrCreate.new
      )
        @input_validator = input_validator
        @user_finder = user_finder
      end

      def call(params, group)
        validated_params = yield input_validate(params)
        yield can_be_joined?(group, validated_params.to_h)
        save(group, validated_params.to_h)
      end

      private

      attr_reader :input_validator, :user_finder

      def input_validate(params)
        input_validator.call(params).to_monad
      end

      def can_be_joined?(group, validated_params)
        group.joined_user?(validated_params) ? Failure(:already_joined) : Success()
      end

      def save(group, validated_params)
        user = yield user_finder.call(validated_params)
        Success(group.join_user(user))
      end
    end
  end
end
