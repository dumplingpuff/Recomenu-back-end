class EntriesController < OpenReadController


  before_filter :set_entry, only: [:show, :update, :destroy]
  skip_before_action :authenticate, only: [:index, :show]

  def index
    render json: Entry.all
  end

  def show
    render json: @entry
  end

  def create
    @entry = Entry.new(entry_params)

    if @entry.save
      render json: @entry, status: :created
    else
      render json: @entry.errors, status: :unprocessable_entity
    end
  end

  def update
    if @entry.update(entry_params)
      render json: @entry, status: :ok
    else
      render json: @entry.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @entry.destroy
    head :no_content
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
