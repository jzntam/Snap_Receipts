class ReportsController < ApplicationController
  def index
    @reports = Report.all.order("created_at DESC")
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
    @receipt = Receipt.new
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
    respond_to do |format|
      if @report.destroy
        format.js {render}
        format.html {redirect_to reports_path, notice: "Report Deleated"}
      else
        format.js {render}
        format.html {redirect_to reports_path, notice: "Unable to Delete"}
      end
    end
  end

  private

  def report_params
    params.require(:report).permit(:title, :description)
  end

end
