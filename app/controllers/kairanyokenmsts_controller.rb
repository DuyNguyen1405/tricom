class KairanyokenmstsController < ApplicationController
  before_action :require_user!
  before_action :set_kairanyokenmst, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @kairanyokenmsts = Kairanyokenmst.all
    respond_with(@kairanyokenmsts)
  end

  def show
    respond_with(@kairanyokenmst)
  end

  def new
    @kairanyokenmst = Kairanyokenmst.new
    respond_with(@kairanyokenmst)
  end

  def edit
  end

  def create
    @kairanyokenmst = Kairanyokenmst.new(kairanyokenmst_params)
    flash[:notice] = t "app.flash.new_success" if @kairanyokenmst.save
    respond_with(@kairanyokenmst, location: kairanyokenmsts_url)

  end

  def update
    flash[:nitice] = t "app.flash.update_success" if @kairanyokenmst.update(kairanyokenmst_params)
    respond_with(@kairanyokenmst, location: kairanyokenmsts_url)
  end

  def destroy
    @kairanyokenmst.destroy
    respond_with(@kairanyokenmst, location: kairanyokenmsts_url)
  end

  def import
    if params[:file].nil?
      flash[:alert] = t "app.flash.file_nil"
      redirect_to kairanyokenmsts_path
    elsif File.extname(params[:file].original_filename) != ".csv"
      flash[:danger] = t "app.flash.file_format_invalid"
      redirect_to kairanyokenmsts_path
    else
      begin
        Kairanyokenmst.transaction do
          Kairanyokenmst.delete_all
          Kairanyokenmst.reset_pk_sequence
          Kairanyokenmst.import(params[:file])
          notice = t 'app.flash.import_csv'
          redirect_to :back, notice: notice
        end
      rescue => err
        flash[:danger] = err.to_s
        redirect_to kairanyokenmsts_path
      end
    end
  end

  def export_csv
    @kairanyokens = Kairanyokenmst.all

    respond_to do |format|
      format.html
      format.csv { send_data @kairanyokens.to_csv, filename: "回覧用件マスタ.csv" }
    end
  end

  private
    def set_kairanyokenmst
      @kairanyokenmst = Kairanyokenmst.find(params[:id])
    end

    def kairanyokenmst_params
      params.require(:kairanyokenmst).permit(:名称, :備考, :優先さ)
    end
end
