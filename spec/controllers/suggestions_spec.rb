require 'rails_helper'

RSpec.describe SuggestionsController do
  def suggestion_params
    {
      name: 'Bob-o',
      restaurant: 'McDonalds'
    }
  end

  def suggestion
    Suggestion.first
  end




  before(:all) do
    Suggestion.create!(suggestion_params)
  end

  after(:all) do
    Suggestion.delete_all
  end

  describe 'GET index' do
    before(:each) { get :index }
    it 'is succesful' do
      expect(response.status).to eq(200)
    end

    it 'renders a JSON response' do
      suggestions_collection = JSON.parse(response.body)
      expect(suggestions_collection).not_to be_nil
    end
  end

  describe 'GET show' do
    it 'is successful' do
      get :show, id: suggestion.id

      expect(response.status).to eq(200)
    end

    it 'renders a JSON response' do
      get :show, id: suggestion.id

      suggestion_response = JSON.parse(response.body)
      expect(suggestion_response).not_to be_nil
    end
  end

  context 'when authenticated' do
    before(:each) do
      request.env['HTTP_AUTHORIZATION'] = "Token token=#{user.token}"
    end

    describe 'POST create' do
      before(:each) do
        post :create, suggestion: suggestion_params, format: :json
      end

      it 'is successful' do
        expect(response).to be_successful
      end

      it 'renders a JSON response' do
        suggestion_response = JSON.parse(response.body)

        expect(suggestion_response).not_to be_nil
      end
    end

    describe 'PATCH update' do
      def suggestion_diff
        { restaurant: 'Applebees' }
      end

      before(:each) do
        patch :update, id: suggestion.id, suggestion: suggestion_diff, format: :json
      end

      it 'is successful' do
        expect(response).to be_successful
      end

      it 'renders a JSON response' do
        suggestion_response = JSON.parse(response.body)
        expect(suggestion_response).not_to be_nil
      end
    end

    describe 'DELETE destroy' do
      it 'is successful and returns an empty response' do
        delete :destroy, id: suggestion.id, format: :json

        expect(response).to be_successful
        expect(response.body).to be_empty
      end
    end
  end

  context 'when not authenticated' do
    before(:each) do
      request.env['HTTP_AUTHORIZATION'] = nil
    end

    describe 'POST create' do
      it 'is not successful' do
        post :create, suggestion: suggestion_params
        expect(response).not_to be_successful
      end
    end

    describe 'PATCH update' do
      it 'is not successful' do
        patch :update, id: suggestion.id
        expect(response).not_to be_successful
      end
    end

    describe 'DELETE destroy' do
      it 'is not successful' do
        delete :destroy, id: suggestion.id
        expect(response).not_to be_successful
      end
    end
  end
end
