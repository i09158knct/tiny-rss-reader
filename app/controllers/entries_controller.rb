class EntriesController < ApplicationController
  before_action :set_entry, only: [:update]

  def update

    respond_to do |format|
      if @entry.update entry_params
        format.json { head :no_content }
      else
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entry
      @entry = Entry.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def entry_params
      params.require(:entry).permit(:unread)
    end
end
