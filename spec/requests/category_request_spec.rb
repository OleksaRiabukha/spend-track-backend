require 'rails_helper'


RSpec.describe CategoriesController, type: :request do
  let!(:user) { FactoryBot.create(:user) }

  describe 'POST/categories' do

    before do
      FactoryBot.build(:category)
      post categories_path, params: params, headers: auth_headers(user)
    end

    context 'when category is created with valid attributes' do
      let(:params) { { category: attributes_for(:category) } }

      it 'return code 200 upon successful creation with valid attributes' do
        expect(response).to be_ok
      end

      it 'return JSON hash with valid details upon successful creation' do
        expect(response).to match_response_schema('category')
      end

      it 'add category to database up successful creation ' do
        expect(Category.count).to eq(1)
      end
    end

    context "when category is created with invalid attributes" do
      let(:params) { { category: { name: " "} } }

      it 'return 400 code upon attempt of creation' do
        expect(response).to be_bad_request
      end

      it 'return a valid JSON hash with errors' do
        expect(response).to match_response_schema("error")
      end

      it 'not add user with invalid attributes to database' do
        expect(Category.count).to eq(0)
      end
    end
  end

  describe 'GET/categories#id' do
    before do
      get "/api/categories/#{category_id}", headers: auth_headers(user)
    end

    context "when user tries to access existing category" do
      let(:category) { FactoryBot.create(:category)}
      let(:category_id) { category.id }

      it "return a 200 code" do
        expect(response).to be_ok
      end

      it "return a JSON with valid details" do
        expect(response).to match_response_schema("category")
      end
    end

    context "when user tries to access non-existing category" do 
      let(:category_id) { 33 }
      
      it "return a 404 code if category not found" do
        expect(response).to be_not_found 
      end
    end
  end

  describe "GET/categories" do
    before do 
      get categories_path, headers: auth_headers(user)
    end

    context "when user tries to get list of categories" do
      let(:categories) { FactoryBot.create_list(:category, 2)}

      it "return a 200 code upon successful request" do
        expect(response).to be_ok
      end
    end
  end
end