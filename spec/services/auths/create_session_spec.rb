RSpec.describe Auths::CreateSessionService do
  subject { described_class }

  context 'Create new session' do
    let(:valid_params) {{ email: 'u101@test.com', password: 'givemeatoken' }}
    let(:invalid_params) {{ email: 'u101@test.com', password: 'invalid_token' }}

    before do
      FactoryBot.create(:user, email: 'u101@test.com', password: 'givemeatoken')
    end

    it 'With valid params' do
      expect { subject.call(user_params: valid_params) }.to change { UserSession.count }.from(0).to(1)
    end

    it 'With invalid params' do
      expect { subject.call(user_params: invalid_params) }.not_to change { UserSession.count }
    end
  end
end