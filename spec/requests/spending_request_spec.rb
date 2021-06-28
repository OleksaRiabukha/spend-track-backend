require "rails_helper"

RSpec.describe SpendingsController, type: :request do
  let!(:category) { FactoryBot.create(:category) }
  let!(:user) { FactoryBot.create(:user) }

  describe "POST/spendings" do
    before do
      post spendings_path, params: params, headers: auth_headers(user)
    end

    context "when user creates spending with valid attributes" do
      let(:params) { { spending: attributes_for(:spending, category_id: category.id, user: user) } }

      it "return a 200 code" do
        expect(response).to be_ok
      end

      it "return a JSON with valid attributes" do
        expect(response).to match_response_schema("spending")
      end

      it "add spending to database" do
        expect(Spending.count).to eq(1)
      end
    end

    context "when user creates spending with invalid attributes" do
      let(:params) { { spending: { description: "" } } }

      it "return a 400 code" do
        expect(response).to be_bad_request
      end

      it "return a JSON with errors details" do
        expect(response).to match_response_schema("error")
      end

      it "not add spending to database" do
        expect(Spending.count).to eq(0)
      end
    end 
  end


  describe "GET/spendings#id" do
    before do
      get "/api/spendings/#{spending_id}", headers: auth_headers(user)
    end

    context "when user access existing spending" do
      let(:spending_id) { FactoryBot.create(:spending, category_id: category.id, user_id: user.id).id }

      it "return a 200 code" do
        expect(response).to be_ok
      end

      it "return a JSON with spending details" do
        expect(response).to match_response_schema("spending")
      end
    end

    context "when user access non-existent spending" do
      let(:spending_id) { 999 }

      it "return a 404 code" do
        expect(response).to be_not_found
      end
    end
  end

  describe "PUT/spendings#id" do
      let(:spending_id) { FactoryBot.create(:spending, category_id: category.id, user_id: user.id).id }
      let(:params) { { spending: attributes_for(:spending, category_id: category.id, user_id: user.id) } }

    before do
      put "/api/spendings/#{spending_id}", params: params, headers: auth_headers(user)
    end

    context "when user updates existing spending with valid attributes" do
      it 'return a 200 code' do
        expect(response).to be_ok
      end

      it 'return a JSON with valid details of spending' do
        expect(response).to match_response_schema("spending")
      end
    end

    context "when user updates non-existent spending" do
      let(:spending_id) { 999 }

      it "return a code 404" do
        expect(response).to be_not_found
      end
    end

    context "when user updates spending with invalid attributes" do
      let(:params) { { spending: { description: ""} } }

      it "return a 400 code" do
        p response.body
        expect(response).to be_bad_request
      end
    end
  end

  describe "DELETE/spendings#id" do
    let(:spending) { FactoryBot.create(:spending, category_id: category.id, user_id: user.id) }

    before do
      delete "/api/spendings/#{spending_id}", headers: auth_headers(user)
    end

    context "when user deletes existing spending" do
      let(:spending_id) { spending.id }
      it "return a 204 code" do
        expect(response).to be_no_content
      end
    end

    context "when user deletes non-existent spending" do
      let(:spending_id) { 999 }

      it "return a 404 code" do
        expect(response).to be_not_found
      end
    end
  end


  describe "GET/spendings" do 
    let!(:spendings) { FactoryBot.create_list(:spending, 2, category_id: category.id, user_id: user.id) }
    before do
      get spendings_path, headers: auth_headers(user)
    end

    context "when user access spendings list" do
      it "return a 200 code" do
        expect(response).to be_ok
      end

      it 'return a JSON with valid details' do
        expect(response).to match_response_schema("spendings")
      end
    end
  end

end