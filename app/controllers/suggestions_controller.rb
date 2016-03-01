class SuggestionsController < ApplicationController
  before_filter :set_suggestion, only: [:show, :update, :destroy]
  before_filter :suggestion_params, only: [:create]
  skip_before_action :authenticate

  def index
    render json: Suggestion.all
  end

  def show
    render json: @suggestion
  end

  def create

    @suggestion = current_user.entries.new(suggestion_params)

    if @suggestion.save
      render json: @suggestion, status: :created
    else
      render json: @suggestion.errors, status: :unprocessable_entity
    end
  end

  def update

    if @suggestion.update(suggestion_params)
      render json: @suggestion, status: :ok
    else
      render json: @suggestion.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if current_user['id'] == @suggestion.user_id
      @suggestion.destroy
      head :no_content
    else
      render json: @suggestion.errors, status: :unprocessable_entity
    end
  end

  def set_suggestion
    @suggestion = Suggestion.find(params[:id])
  end
  private :set_suggestion

  def suggestion_params
    params.require(:suggestion).permit!
  end
  private :suggestion_params

end
