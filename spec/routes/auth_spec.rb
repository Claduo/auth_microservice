RSpec.describe AuthRoutes, type: :routes do
  describe "POST /v1/auth" do
    context "with valid header" do
      let(:session) { FactoryBot.create(:user_session) }
      let(:token) { JwtEncoder.encode(uuid: session.uuid) }

      it do
        post '/', {}, "HTTP_AUTHORIZATION" => "Bearer #{token}"

        expect(last_response.status).to eq(201)
        expect(response_body['auth']).to include("user_id" => session.user.id)
      end
    end

    context "with invalid header" do
      let(:token) { 'auth_token' }
      it do
        post '/', {}, "HTTP_AUTHORIZATION" => token
        expect(last_response.status).to eq(422)
      end
    end
  end
end