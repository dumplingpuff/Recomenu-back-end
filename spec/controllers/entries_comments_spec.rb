require 'rails_helper'

RSpec.describe CommentsController do
  def entry_params
    {
      restaurant: 'Burger King',
      content: 'You won\'t believe what happens next...'
    }
  end

  def comment_params
    {
      message: 'This is linkbait.'
    }
  end

  def entry
    Entry.first
  end

  before(:all) do
    Entry.create!(entry_params)
  end

  after(:all) do
    Entry.destroy_all
  end

  describe 'GET entries#index' do
    before(:each) do
      get :index, entry_id: entry.id
    end

    it 'is succesful' do
      expect(response.status).to eq(200)
    end

    it 'renders a JSON response with embedded comments' do
      entry_comments_collection = JSON.parse(response.body)
      expect(entry_comments_collection['comments']).not_to be_nil
    end
  end

  describe 'POST create' do
    before(:each) do
      post :create,
           entry_id: entry.id, comment: comment_params, format: :json
    end

    it 'is successful' do
      expect(response).to be_success
    end

    it 'renders a JSON response' do
      entry_comment_response = JSON.parse(response.body)
      expect(entry_comment_response).not_to be_nil
    end
  end
end
