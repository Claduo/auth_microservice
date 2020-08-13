RSpec.describe Auths::CreateUserService do
  subject { described_class }

  context 'Create new user' do
    let(:valid_params) {{ name: 'User_101', email: 'u101@test.com', password: 'givemeatoken' }}
    let(:invalid_params) {{ name: 'User_101', email: 'u101.com', password: '' }}


    it 'With valid params' do
      expect { subject.call(user_params: valid_params) }.to change { User.count }.from(0).to(1)
    end

    it 'With invalid params' do
      expect { subject.call(user_params: invalid_params) }.not_to change { User.count }
    end
  end
end
