RSpec.describe UserRoutes, type: :routes do
  describe 'POST /v1/signup' do
    context 'missing parameters' do
      it 'returns an error' do
        post '/', params: {name: 'User_101', email: 'u101@test.com', password: ''}
        expect(last_response.status).to eq(422)
      end
    end

    context 'valid parameters' do
      let(:user_params) { { name: 'User_101', email: 'u101@test.com', password: 'givemeatoken' } }
      it 'returns created status' do
        post '/', user_params
        expect(last_response.status).to eq(201)
      end
    end
  end
end
