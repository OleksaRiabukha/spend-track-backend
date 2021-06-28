require 'rails_helper'


RSpec.describe UsersController, type: :request do
  before do
    FactoryBot.build(:user)
    post users_path, params: params
  end

  describe 'POST/users' do
    context "when user is created with valid attributes" do
      let(:params) { { user: attributes_for(:user) } }

      it 'return 200 code upon creation with valid attributes' do
        expect(response).to be_ok
      end

      it 'return JSON hash with valid details upon successful creation' do
        expect(response).to match_response_schema("user")
      end

      it 'add user to database up successful creation ' do
        expect(User.count).to eq(1)
      end
    end

    context 'when user is created with invalid attributes' do
      let(:params) { { user: { first_name: ""} } }

      it 'return 400 code upon attempt of creation' do
        expect(response).to be_bad_request
      end

      it 'return a valid JSON hash with errors' do
        expect(response).to match_response_schema("error")
      end

      it 'not add user with invalid attributes to database' do
        expect(User.count).to eq(0)
      end
    end
  end
end