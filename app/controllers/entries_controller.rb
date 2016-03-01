class EntriesController < OpenReadController

  before_filter :set_entry, only: [:show, :update, :destroy]
  before_filter :entry_params, only: [:create]
  skip_before_action :authenticate, only: [:index, :show]

  def index
    render json: Entry.all.order(created_at: :desc)
  end

  def show
    render json: @entry
  end

  def create

    @entry = current_user.entries.new(entry_params)

    if @entry.save
      render json: @entry, status: :created
    else
      render json: @entry.errors, status: :unprocessable_entity
    end
  end

  def update

    if current_user['id'] == @entry.user_id
      render json: @entry, status: :ok
    else
      render json: @entry.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if current_user['id'] == @entry.user_id
      @entry.destroy
      head :no_content
    else
      render json: @entry.errors, status: :unprocessable_entity
    end
  end

  def set_entry
    @entry = Entry.find(params[:id])
  end
  private :set_entry

  def entry_params
    params.require(:entry).permit!
  end
  private :entry_params
end
