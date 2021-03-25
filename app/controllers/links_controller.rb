class LinksController < ApplicationController

  def create
    result = CreateRecordVisitedLink.call(params[:links])
    render json: result.data, status: result.code
  end

end

