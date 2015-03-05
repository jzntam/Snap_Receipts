class ReportsController < ApplicationController
  def index
    @search = Search.new
    @reports = Report.all.order("created_at DESC")
    @report = Report.new
  end

  def create
    @report = Report.new(report_params)
    respond_to do |format|
      if @report.save
        format.html {redirect_to reports_path, notice: "Report Created"}
        format.js {render}
      else
        format.html {redirect_to reports_path, notice: "Report NOT Created"}
        format.js {render}
      end
    end
  end

  def show
    @search = Search.new
    @locations = Receipt.near([49.2314389, -123.0657958], 20, units: :km)
    @report = Report.find(params[:id])
    @receipt = Receipt.new
  end

  def edit
    @report = Report.find(params[:id])
  end

  def update
    @report = Report.find(params[:id])
    respond_to do |format|
      if @report.update(report_params)
        format.html {redirect_to reports_path, notice: "Report Updated"}
        format.js {render}
      else
        format.html {redirect_to reports_path, notice: "Invalid update parameters"}
        format.js {render}
      end
    end
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
