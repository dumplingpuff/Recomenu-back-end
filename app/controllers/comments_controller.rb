class CommentsController < OpenReadController
  before_filter :set_comment, only: [:show, :update, :destroy]
  skip_before_action :authenticate, only: [:index, :show, :create]

  def index
    render json: Comment.all
  end

  def show
    render json: @comment
  end

  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      render json: @comment, status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def update
    if @comment.update(comment_params)
      render json: @comment, status: :ok
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
    head :no_content
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end
  private :set_comment

  def comment_params
    params.require(:comment).permit!
  end
  private :comment_params
end
