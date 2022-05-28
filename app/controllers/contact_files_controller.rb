class ContactFilesController < ApplicationController
  before_action :set_contact_file, only: %i[ show edit update destroy ]
  before_action :rooted

  # GET /contact_files or /contact_files.json
  def index
    @contact_files = params[:status] ? current_user.contact_files.where(status: params[:status]).page(params[:page]).per(5) : current_user.contact_files.page(params[:page]).per(5)
  end

  # GET /contact_files/new
  def new
    @contact_file = ContactFile.new
  end

  # POST /contact_files or /contact_files.json
  def create
    @contact_file = ContactFile.new(contact_file_params)

    respond_to do |format|
      if @contact_file.save
        CreateContactJob.perform(@contact_file, params[:contact_file][:file_url])
        format.html { redirect_to contact_files_url, notice: 'Contact file was successfully created.' }
        format.json { render :show, status: :created, location: @contact_file }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @contact_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contact_files/1 or /contact_files/1.json
  def destroy
    @contact_file.destroy

    respond_to do |format|
      format.html { redirect_to contact_files_url, notice: 'Contact file was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_contact_file
    @contact_file = ContactFile.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def contact_file_params
    params.require(:contact_file).permit(:file_url, :user_id)
  end
end
