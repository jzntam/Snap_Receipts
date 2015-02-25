class ReceiptsController < ApplicationController
  
  def index
    @receipts = Receipt.all
    @report = Report.find(params[:report_id])
  end

  
  def new
    @report = Report.find(params[:report_id])
    @receipt = Receipt.new
  end

  def create
    @report = Report.find(params[:report_id])
    @receipt = Receipt.new receipt_params
    @receipt.report = @report
    if @receipt.save
      redirect_to @report, notice: "REceipt Created"
    else
      redirect_to :back, notice: "No worky"
      # render :new
    end
    # render text: params
  end

  def show
  end
  
  def edit
    @receipt = Receipt.find(params[:id])
    @report = Report.find(params[:report_id])
  end
  
  def update
    @receipt = Receipt.find params[:id]
    if @receipt.update receipt_params
      redirect_to report_path(@receipt.report_id)
      # redirect_to report_receipts_path
    else
      render :edit
    end
  end

  def destroy
    @receipt = Receipt.find params[:id]
    @receipt.destroy
    redirect_to report_path(@receipt.report_id)
    # redirect_to :back
    # render text: params
  end

  private

  def receipt_params
    params.require(:receipt).permit(:business_name, :image, :sub_total, :tax_total, :total, :tax_type, :category, :comment)
  end

end
