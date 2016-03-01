class CommentsController < OpenReadController
  skip_before_action :authenticate, only: [:index, :show]

  def index
    render json: Comment.all
  end
end
