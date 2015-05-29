class ReceiptsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @receipts = Receipt.all
    @report = Report.find(params[:report_id])
    #@entire_receipts = Receipt.all
    @receipts = @receipts.search(params[:search]) if params[:search].present?
    @receipts = @receipts.text_search(params[:query]) if params[:query].present?
    respond_to do |format|
      format.html
      format.csv { send_data @report.receipts.to_csv }
      format.xls 
    end
  end
  
  def new
    @report = Report.find(params[:report_id])
    @receipt = Receipt.new
  end

  def create
    @report = Report.find(params[:report_id])
    @receipt = Receipt.new receipt_params
    @receipt.report = @report
    respond_to do |format|
      if @receipt.save
        format.html {
          flash.now[:notice] = "Receipt Created"
          redirect_to @report
        }
        format.js {render}
      else
        format.html { 
          flash.now[:alert] = "Unable to create. Missing image or tax type"
          redirect_to @report
        }
        format.js {render}
        # render :new
      end
    end
    # render text: params
  end

  def edit
    @receipt = Receipt.find(params[:id])
    @report = Report.find(params[:report_id])
  end
  
  def update
    @locations = Receipt.near([49.2314389, -123.0657958], 20, units: :km)    
    @report = Report.find(params[:report_id])
    @receipt = Receipt.find params[:id]
    respond_to do |format|
      if @receipt.update(receipt_params)
        address_empty?
        format.html {redirect_to report_path(@receipt.report_id), notice: "Receipt Updated"}
        format.js {render}
      else
        format.html {redirect_to report_path(@receipt.report_id), notice: "Error not Updated"}
        format.js {render}
      end
    end
  end

  def destroy
    @locations = Receipt.near([49.2314389, -123.0657958], 20, units: :km)
    @report = Report.find(params[:report_id])
    @receipt = Receipt.find params[:id]
    respond_to do |format|
      if @receipt.destroy
        format.html {redirect_to report_path(@receipt.report_id), notice: "Receipt Deleted"}
        format.js {render}
      else
        format.html {redirect_to report_path(@receipt.report_id), notice: "Receipt not Deleted"}
        format.js {render}
      end
    end
    # render text: params
  end

  private

  def receipt_params
    params.require(:receipt).permit(:business_name, :image, :sub_total, :tax_total, :total, :tax_type, :category, :comment, :address)
  end

  def address_empty?
    if @receipt.address == ""
      @receipt.longitude = nil
      @receipt.latitude = nil
      @receipt.save
    end
  end
end
