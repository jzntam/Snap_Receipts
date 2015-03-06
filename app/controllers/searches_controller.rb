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
    @receipts = @receipts.key_search(@search.keyword) if @search.keyword.present?
    @receipts = @receipts.not_time(@search.not_name) if @search.not_name.present?
    @receipts = @receipts.cat_search(@search.category) if @search.category.present?
    @receipts = @receipts.time_search(@search.between) if @search.between.present?
    #@receipts = @receipts.not_time(@search.title) if @search.title.present?
    #@receipts = @receipts.time_search(@search.not_name) if @search.not_name.present?
    #@receipts = @receipts.not_time(@search.category) if @search.category.present?
  end

    private 
      def search_params
        params.require(:search).permit(:keyword, :title, :between, :not_name, :category)
        #@search = Search.find(params[:search])
        #params.require(:receipt).permit(:business_name, :image, :sub_total, :tax_total, :total, :tax_type, :category, :comment, :address)
      end
end
