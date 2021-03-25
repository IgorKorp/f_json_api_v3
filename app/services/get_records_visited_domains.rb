class GetRecordsVisitedDomains < Service
  include Callable

  attr_accessor :array_domain
  def initialize(from = nil, to = nil)
    @from = from.nil? ? 0 : from.to_i
    @to = to.nil? ? -1 : to.to_i
    @redis_model = Domain
  end

  def call
    find_objects
    check_array
  end

  private
  def find_objects
    self.array_domain = @redis_model.get_array_uniq_domains(from: @from, to: @to)
  end

  def check_array
    if @array_domain.empty?
      return error({domains: @array_domain, status: 404, error: 'Domains not found'}, code: 404)
    end
    if @from == 0 && @to == -1
      return  success({domains: @array_domain, status: 200, title: 'Date is not transmitted, were received all domains'})
    end
    success({domains: @array_domain, status: 'ok'})
  end
end