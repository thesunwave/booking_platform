require 'rails_helper'

RSpec.describe Groups::Operations::JoinUser do
  subject do
     described_class.new(
       params,
       record: model,
       input_validator: input_validator,
       user_exists_check: user_exists_check,
       user_creator: user_creator
      ).call
  end

  let(:model) { FactoryBot.create(:group) }

  describe 'join user to a group' do
    let(:params) { { email: 'test@example.com' } }

    let(:user) { FactoryBot.create(:user, email: params[:email])}

    context 'when user is already joined' do
      let(:input_validator) { -> (*) { Dry::Monads::Success(params) } }
      let(:user_exists_check) do
        double(new: -> { Dry::Monads::Success(user) })
      end
      let(:user_creator) { -> { Dry::Monads::Success() } }

      before do
        model.users << user
      end

      it 'will not add user to a group' do
        expect { subject }.not_to change { model.users.count }
      end
    end

    context 'when user is not joined' do
      let(:input_validator) { -> (*) { Dry::Monads::Success(params) } }
      let(:user_exists_check) do
        double(new: -> { Dry::Monads::Success(user) })
      end
      let(:user_creator) { -> { Dry::Monads::Success() } }

      it 'will be added user to a group' do
        expect { subject }.to change { model.users.count }
      end
    end
  end
end
