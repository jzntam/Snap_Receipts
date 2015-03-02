class SearchesController < ApplicationController
   def new 
    @search = Search.new
  end

  def create
    @search = Search.create!(search_params)
    #@search = Search.create!(params[:search])
    redirect_to @search
  end

  def show
    @search = Search.find(params[:id])
    @receipts = Receipt.where(nil)
    @receipts = @receipts.time_search(@search.keyword) if @search.keywords.present?
    #@receipts = @receipts.time_search(@search.title) if @search.title.present?
    #@receipts = @receipts.time_search(@search.name) if @search.name.present?
    #@receipts = @receipts.not_time(@search.part) if @search.part.present?
  end

    private 
      def search_params
        params.require(:search).permit(:keyword) #:title, :keyword, :name, :part)
        #@search = Search.find(params[:search])
        #params.require(:receipt).permit(:business_name, :image, :sub_total, :tax_total, :total, :tax_type, :category, :comment, :address)
      end
end
