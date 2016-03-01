require 'rails_helper'

RSpec.describe 'Entry Comments API' do
  def user_params
    {
      email: 'be@baby.com',
      password: 'foobarbaz',
    }
  end

  def entry_params
    {
      restaurant: 'Micky D\'s',
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

  def entry_comments
    entry.comments
  end

  def entry_first_comment
    entry_comments.first
  end

  before(:all) do
    User.create!(user_params)
    Entry.create!(entry_params)
    entry.comments.create!(comment_params)



    # # Create an unassociated comment to prove scoping
    # Comment.create!(comment_params)
  end

  after(:all) do
    User.destroy_all
  end

  describe 'GET /entries/:id/comments' do
    it 'lists all comments for an entry' do
      get "/entries/#{entry.id}/comments"

      expect(response).to be_success

      parsed_response = JSON.parse(response.body)
      expect(parsed_response['comments'].length).to eq(entry_comments.count)
      expect(
        parsed_response['comments'].first['content']
      ).to eq(entry_first_comment.content)
    end
  end

  describe 'POST /entries/:id/comments' do
    it 'creates an comment on an entry' do
      post "/entries/#{entry.id}/comments",
           comment: comment_params,
           format: :json

      expect(response).to be_success

      entry_comment_response = JSON.parse(response.body)

      expect(entry_comment_response['id']).not_to be_nil
      expect(entry_comment_response['entry_id']).not_to be_nil
      expect(
        entry_comment_response['content']
      ).to eq(comment_params[:content])
    end
  end
end
