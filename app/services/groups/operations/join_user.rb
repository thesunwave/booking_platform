module Groups
  module Operations
    class JoinUser < Core::Operation
      def initialize(params, record: ,
        input_validator: Users::Validators::NewUserContract.new,
        user_exists_check: Users::Operations::CheckExists,
        user_creator: Users::Operations::Create
      )
        @params = params
        @input_validator = input_validator
        @record = record
        @user_creator = user_creator
        @user_exists_check = user_exists_check
      end

      def call
        validated_params = yield input_validate
        yield business_validate(validated_params.to_h)
        save(validated_params.to_h)
      end

      private

      attr_reader :params, :record, :input_validator, :user_creator, :user_exists_check

      def input_validate
        input_validator.call(params[:group]).to_monad
      end

      def business_validate(validated_params)
        return Failure(:already_exists) if record.users.where(validated_params).exists?
        Success()
      end

      def save(validated_params)
        user_check_result = user_exists_check.new(validated_params[:email]).call
        if user_check_result == Success(:user_not_exists)
          user = yield user_creator.new(validated_params).call

          record.users << user
          return Success(:created)
        end

        record.users << user_check_result.value!

        Success(:created)
      end
    end
  end
end
