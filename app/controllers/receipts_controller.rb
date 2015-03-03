class ReceiptsController < ApplicationController
  
  def index
    @receipts = Receipt.all
    @report = Report.find(params[:report_id])
    respond_to do |format|
      format.html
      format.csv { send_data @receipts.to_csv }
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
        format.html {redirect_to @report, notice: "Receipt Created"}
        format.js {render}
      else
        format.html {redirect_to :back, notice: "No worky"}
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
        format.html {redirect_to report_path(@receipt.report_id)}
        format.js {render}
      else
        format.html {redirect_to report_path(@receipt.report_id)}
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
        format.html {redirect_to report_path(@receipt.report_id)}
        format.js {render}
      else
        format.html {redirect_to report_path(@receipt.report_id)}
        format.js {render}
      end
    end
    # render text: params
  end

  private

  def receipt_params
    params.require(:receipt).permit(:business_name, :image, :sub_total, :tax_total, :total, :tax_type, :category, :comment, :address)
  end

end
