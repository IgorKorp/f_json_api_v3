class DomainsController < ApplicationController

  def index
    result = GetRecordsVisitedDomains.call(params[:from], params[:to])
    render json: result.data, status: result.code
  end

end
