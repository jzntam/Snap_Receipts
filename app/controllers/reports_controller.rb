class ReportsController < ApplicationController
  def index
    @reports = Report.all.order("created_at DESC")
  end

  def new
    @report = Report.new
  end

  def create
    @report = Report.new(report_params)  
    if @report.save
      redirect_to reports_path, notice: "Report Created"
    else
      render :new
    end
  end

  def show
    @report = Report.find(params[:id])
    @report.receipts.order("created_at DESC")
  end

  def edit
    @report = Report.find(params[:id])
  end

  def update
    @report = Report.find(params[:id])
    @report.update(report_params)

    redirect_to reports_path
  end

  def destroy
    @report = Report.find(params[:id])
    @report.destroy
    redirect_to reports_path
  end

  private

  def report_params
    params.require(:report).permit(:title, :description)
  end

end
