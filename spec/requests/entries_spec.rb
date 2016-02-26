require 'rails_helper'

RSpec.describe 'Entries API' do
  def entry_params
    {
      restaurant: 'McDonalds',
      content: 'This place is garbage'
    }
  end

  def entries
    Entry.all
  end

  def entry
    Entry.first
  end

  def user_params
    {
      email: 'alice@example.com',
      password: 'foobarbaz',
      password_confirmation: 'foobarbaz'
    }
  end

  def user
    User.first
  end

  before(:all) do
    User.create!(user_params)
    Entry.create!(entry_params)
  end

  after(:all) do
    Entry.delete_all
    User.delete_all
  end

  describe 'GET /entries' do
    it 'lists all entries' do
      get '/entries'

      expect(response).to be_success

      entry_response = JSON.parse(response.body)
      expect(entry_response.length).to eq(entries.count)
      expect(entry_response['entries'].first['restaurant']).to eq(entry.restaurant)
    end
  end

  describe 'GET /entries/:id' do
    it 'shows one entry' do
      get "/entries/#{entry.id}"

      expect(response).to be_success

      entry_response = JSON.parse(response.body)
      expect(entry_response['id']).to eq(entry.id)
      expect(entry_response['restaurant']).to eq(entry.restaurant)
    end
  end

  context 'when authenticated' do
    def headers
      {
        'HTTP_AUTHORIZATION' => "Token token=#{user.token}"
      }
    end

    describe 'POST /entries' do
      it 'creates an entry' do
        post '/entries', { entry: entry_params }, headers

        expect(response).to be_success

        entry_response = JSON.parse(response.body)
        expect(entry_response['id']).not_to be_nil
        expect(entry_response['restaurant']).to eq(entry_params[:restaurant])
      end
    end

    describe 'PATCH /entries/:id' do
      def entry_diff
        { restaurant: 'Two Stupid Tricks' }
      end

      it 'updates an entry' do
        patch "/entries/#{entry.id}", { entry: entry_diff }, headers

        expect(response).to be_success

        entry_response = JSON.parse(response.body)
        expect(entry_response['id']).to eq(entry.id)
        expect(entry_response['restaurant']).to eq(entry_diff[:restaurant])
      end
    end

    describe 'DELETE /entries/:id' do
      it 'deletes an entry' do
        delete "/entries/#{entry.id}", nil, headers

        expect(response).to be_success
        expect(response.body).to be_empty
      end
    end
  end

  context 'when not authenticated' do
    def headers
      {
        'HTTP_AUTHORIZATION' => nil
      }
    end

    describe 'POST /entries' do
      it 'is not successful' do
        post '/entries', nil, headers

        expect(response).not_to be_success
      end
    end

    describe 'PATCH /entries/:id' do
      it 'is not successful' do
        patch "/entries/#{entry.id}", nil, headers

        expect(response).not_to be_success
      end
    end

    describe 'DELETE /entries/:id' do
      it 'is not successful' do
        delete "/entries/#{entry.id}", nil, headers

        expect(response).not_to be_success
      end
    end
  end
end
