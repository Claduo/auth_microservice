RSpec.describe UserSessionRoutes, type: :routes do
  describe 'POST /login' do
    context 'missing parameters' do
      let(:params) { {email: 'u101@test.com', password: ''} }
      it 'returns an error' do
        post '/', params
        expect(last_response.status).to eq(422)
      end
    end

    context 'with wrong password' do
      let(:params) { {email: 'u101@test.com', password: 'not_givemeatoken'} }
      it 'returns an error' do
        post '/', params

        expect(last_response.status).to eq(401)
        expect(response_body['errors']).to include('detail' => I18n.t(:invalid_password, scope: 'services.errors.sessions'))
      end
    end

    context 'valid parameters' do
      let(:token) { 'secret_token' }
      let(:params) { {email: 'u101@test.com', password: 'givemeatoken'} }

      before do
        FactoryBot.create(:user, email: 'u101@test.com', password: 'givemeatoken')
        allow(JWT).to receive(:encode).and_return(token)
      end

      it 'returns created status' do
        post '/', params

        expect(last_response.status).to eq(201)
        expect(response_body['auth']).to eq('token' => token)
      end
    end
  end
end
